/*
 * mfcce_xtract.c
 *
 * Created on: Feb 7, 2026
 * Author: edoph
 */

#include "mfcc_extract.h"
#include "main.h"
#include <string.h> // cho memmove, memcpy
#include <math.h>   // cho HUGE_VALF nếu cần
#include "audio_capture.h"
#include "arm_math.h"
#include "debug_uart.h"

// Global buffers (khai báo extern trong .h nếu cần share)
arm_rfft_fast_instance_f32 S_Rfft;
MelFilterTypeDef S_MelFilter;
DCT_InstanceTypeDef S_DCT;
SpectrogramTypeDef S_Spectr;
MelSpectrogramTypeDef S_MelSpectr;
LogMelSpectrogramTypeDef S_LogMelSpectr;
MfccTypeDef S_Mfcc;

static arm_biquad_casd_df1_inst_f32 S_Filter;
static float32_t filter_state[2 * NUM_STAGES];

/* Coeffs are in CMSIS order: {b0,b1,b2, a1, a2} per stage.
 Note: CMSIS expects feedback coefficients with sign such that
 the processing uses the form with +a1*y[n-1], +a2*y[n-2]
 (see CMSIS docs). The arrays below are already prepared.
*/
/* Heart bandpass ≈ 20 - 600 Hz (fs = 16 kHz) - 4th order (2 stages) */
// float32_t filter_coeffs[5 * NUM_STAGES] = {
// /* stage 0 */ 1.0f, 2.0f, 1.0f, 1.9889416051454945f, -0.9890070054442315f,
// /* stage 1 */ 1.0f, -2.0f, 1.0f, 1.6892470409865235f, -0.7338101667589392f
// };

static float32_t filter_coeffs[5 * NUM_STAGES] = {
    /* stage 0 */ 1.0f, 2.0f, 1.0f, 1.9889416051454945f, -0.9890070054442315f,
    /* stage 1 */ 1.0f, -2.0f, 1.0f, 1.6892470409865235f, -0.7338101667589392f};

uint32_t NUM_MEL_COEFS = 0;
// Scratch buffers
static float32_t pInFrame[FRAME_LEN];
static float32_t pOutColBuffer[NUM_MFCC];
static float32_t pWindowFuncBuffer[FRAME_LEN];
static float32_t pSpectrScratchBuffer[FFT_LEN];
static float32_t pDCTCoefsBuffer[NUM_MELS * NUM_MFCC];
static float32_t pMfccScratchBuffer[NUM_MELS];

static float32_t pMelFilterCoefs[MAX_MEL_COEFS];
static uint32_t pMelFilterStartIndices[NUM_MELS];
static uint32_t pMelFilterStopIndices[NUM_MELS];

/* =========================================================================
 * Output: MFCC feature matrix và streaming counter
 * ========================================================================= */
float32_t mfcc_final_features[MFCC_FEATURES][MFCC_TIME_FRAMES] = {0};
uint32_t mfcc_collected = 0;
uint32_t mfcc_frame_count = 0;
uint32_t mfcc_time_total_ms = 0;
uint32_t mfcc_time_max_ms = 0;
uint32_t mfcc_window_start_ms = 0;
// Static state cho delta (per-frame)
// static float32_t prev_mfcc[NUM_MFCC]   = {0};
// static float32_t prev_delta[NUM_MFCC]  = {0};

/* =========================================================================
 * Delta state — librosa.feature.delta width=9 (N=4)
 *
 * Công thức librosa:
 *   d[t] = sum_{n=1}^{N} n * (x[t+n] - x[t-n]) / (2 * sum_{n=1}^{N} n^2)
 *   với N=4: denominator = 2*(1+4+9+16) = 60
 *
 * Trong chế độ streaming (causal), ta không có x[t+n] (frame tương lai).
 * Dùng xấp xỉ causal: chỉ dùng các frame QUÁ KHỨ (one-sided):
 *   d[t] ≈ sum_{n=1}^{4} n * (x[t] - x[t-n]) / 30
 *   (denominator one-sided = sum_{n=1}^{4} n^2 = 1+4+9+16 = 30)
 *
 * Buffer: lưu 4 frame MFCC gần nhất để tính delta
 * ========================================================================= */
#define DELTA_N 4 // tương đương librosa width=9

/* Ring buffer lưu lịch sử MFCC (frame hiện tại + 4 frame trước) */
static float32_t mfcc_history[DELTA_N + 1][NUM_MFCC];  // [5][13]
static float32_t delta_history[DELTA_N + 1][NUM_MFCC]; // [5][13] cho delta2
static uint32_t history_idx = 0;                       // con trỏ vòng trong history buffer
static uint32_t frames_seen = 0;                       // số frame đã xử lý (warm-up)

/* =========================================================================
 * Hằng số delta — tính sẵn tránh chia trong loop
 *   one-sided denom = sum_{n=1}^{4} n^2 = 30
 * ========================================================================= */
#define DELTA_DENOM_INV (1.0f / 30.0f) // = 0.03333...

/* =========================================================================
 * Prototype nội bộ
 * ========================================================================= */

static void compute_delta_causal(
    float32_t history[][NUM_MFCC],
    uint32_t current_idx,
    uint32_t frames_available,
    float32_t *out_delta);

/* =========================================================================
 * Preprocessing_Init
 * ========================================================================= */
void Preprocessing_Init(void)
{
    /* --- Bandpass filter --- */
    memset(filter_state, 0, sizeof(filter_state));
    arm_biquad_cascade_df1_init_f32(&S_Filter, NUM_STAGES, filter_coeffs, filter_state);

    /* --- Delta history reset --- */
    memset(mfcc_history, 0, sizeof(mfcc_history));
    memset(delta_history, 0, sizeof(delta_history));
    history_idx = 0;
    frames_seen = 0;

    /* --- Window function (Hamming) --- */
    if (Window_Init(pWindowFuncBuffer, FFT_LEN, WINDOW_HANN) != 0)
    {
        Error_Handler();
    }

    /* --- RFFT --- */
    arm_rfft_fast_init_f32(&S_Rfft, FFT_LEN);

    /* --- Mel filterbank ---
     * Khớp librosa.feature.mfcc defaults:
     *   n_mels  = 128  (NUM_MELS)
     *   fmin    = 0.0  Hz
     *   fmax    = sr/2 = 1000.0 Hz
     *   formula = Slaney (MEL_SLANEY), normalize=1
     */
    S_MelFilter.pStartIndices = pMelFilterStartIndices;
    S_MelFilter.pStopIndices = pMelFilterStopIndices;
    S_MelFilter.pCoefficients = pMelFilterCoefs;
    S_MelFilter.NumMels = NUM_MELS;     // 128
    S_MelFilter.FFTLen = FFT_LEN;       // 256
    S_MelFilter.SampRate = SAMPLE_RATE; // 2000
    S_MelFilter.FMin = 0.0f;
    S_MelFilter.FMax = (float32_t)SAMPLE_RATE / 2.0f;
    ; // 2000.0 Hz
    S_MelFilter.Formula = MEL_SLANEY;
    S_MelFilter.Normalize = 1;
    S_MelFilter.Mel2F = 1;

    MelFilterbank_Init(&S_MelFilter);
    DebugUART_Log(
        "[MEL] coeffs=%lu first=%.6f last=%.6f\r\n",
        S_MelFilter.CoefficientsLength,
        pMelFilterCoefs[0],
        pMelFilterCoefs[S_MelFilter.CoefficientsLength - 1]);

    if (S_MelFilter.CoefficientsLength > MAX_MEL_COEFS)
    {
        Error_Handler(); // tăng MAX_MEL_COEFS nếu xảy ra
    }
    NUM_MEL_COEFS = S_MelFilter.CoefficientsLength;

    /* --- DCT (Type II ortho) → 13 coefficients từ 128 Mel bins --- */
    S_DCT.NumFilters = NUM_MFCC; // 13
    S_DCT.NumInputs = NUM_MELS;  // 128
    S_DCT.Type = DCT_TYPE_II_ORTHO;
    S_DCT.RemoveDCTZero = 0;
    S_DCT.pDCTCoefs = pDCTCoefsBuffer;
    if (DCT_Init(&S_DCT) != 0)
    {
        Error_Handler();
    }

    /* --- Spectrogram config --- */
    S_Spectr.pRfft = &S_Rfft;
    S_Spectr.Type = SPECTRUM_TYPE_POWER; // power spectrum, khớp librosa melspectrogram
    S_Spectr.pWindow = pWindowFuncBuffer;
    S_Spectr.SampRate = SAMPLE_RATE;
    S_Spectr.FrameLen = FRAME_LEN;
    S_Spectr.FFTLen = FFT_LEN;
    S_Spectr.pScratch = pSpectrScratchBuffer;

    /* --- Mel spectrogram --- */
    S_MelSpectr.SpectrogramConf = &S_Spectr;
    S_MelSpectr.MelFilter = &S_MelFilter;

    /* --- Log Mel spectrogram ---
     * Python: np.log(mel + EPS)  → natural log (ln)
     * Dùng LOGMELSPECTROGRAM_SCALE_LOG nếu thư viện hỗ trợ,
     * hoặc LOGMELSPECTROGRAM_SCALE_DB và bù hệ số khi cần.
     *
     * STM32 AI Audio lib:
     *   LOGMELSPECTROGRAM_SCALE_LOG = natural log (khớp Python)
     *   LOGMELSPECTROGRAM_SCALE_DB  = 10*log10 (KHÔNG khớp)
     *
     * EPS = 1e-8 (khớp Python EPS = 1E-8)
     */
    S_LogMelSpectr.MelSpectrogramConf = &S_MelSpectr;
    S_LogMelSpectr.LogFormula = LOGMELSPECTROGRAM_SCALE_LOG;
    S_LogMelSpectr.Ref = 1.0f;
    S_LogMelSpectr.TopdB = HUGE_VALF; // không clip (Python không clip)
    S_LogMelSpectr.Ref = 1.0f;
    /* --- MFCC --- */
    S_Mfcc.LogMelConf = &S_LogMelSpectr;
    S_Mfcc.pDCT = &S_DCT;
    S_Mfcc.NumMfccCoefs = NUM_MFCC; // 13 static coefficients
    S_Mfcc.pScratch = pMfccScratchBuffer;

    mfcc_frame_count = 0;
    mfcc_time_total_ms = 0;
    mfcc_time_max_ms = 0;
    mfcc_window_start_ms = HAL_GetTick();

    DebugUART_Log("[MFCC] Init done, window timer started\r\n");
}

/* =========================================================================
 * compute_delta_causal
 *
 * Tính delta cho 1 frame theo công thức causal (one-sided) xấp xỉ librosa:
 *   d[t] = sum_{n=1}^{N} n * (x[t] - x[t-n]) / (sum_{n=1}^{N} n^2)
 *
 * @param history       : ring buffer [DELTA_N+1][NUM_MFCC]
 * @param current_idx   : index hiện tại trong ring buffer (frame mới nhất)
 * @param frames_available : số frame đã có trong history (warm-up guard)
 * @param out_delta     : output float[NUM_MFCC]
 * ========================================================================= */
static void compute_delta_causal(
    float32_t history[][NUM_MFCC],
    uint32_t current_idx,
    uint32_t frames_available,
    float32_t *out_delta)
{
    uint32_t ring_size = DELTA_N + 1; // = 5

    for (uint32_t i = 0; i < NUM_MFCC; i++)
    {
        float32_t sum = 0.0f;
        float32_t x_current = history[current_idx][i];

        for (uint32_t n = 1; n <= DELTA_N; n++)
        {
            // index của frame cách n bước về trước trong ring buffer
            uint32_t past_idx = (current_idx + ring_size - n) % ring_size;

            // Nếu chưa đủ warm-up, giả sử x[t-n] = x[0] (zero-pad tương đương librosa)
            float32_t x_past;
            if (frames_available > n)
            {
                x_past = history[past_idx][i];
            }
            else
            {
                x_past = 0.0f; // zero-pad như librosa mode='edge' equiv khi frame đầu
            }

            sum += (float32_t)n * (x_current - x_past);
        }

        out_delta[i] = sum * DELTA_DENOM_INV;
    }
}

/* =========================================================================
 * compute_mfcc_one_frame
 *
 * Tính MFCC(13) + Δ(13) + ΔΔ(13) = 39 features cho 1 frame streaming.
 *
 * @param pInSignal     : int16_t[FRAME_LEN] — frame audio thô từ I2S
 * @param pOutMfccFrame : float[39] — output features
 * ========================================================================= */
void compute_mfcc_one_frame(int16_t *pInSignal, float *pOutMfccFrame)
{
    if (!pInSignal || !pOutMfccFrame)
        return;

    memset(pInFrame, 0, sizeof(pInFrame));

    buf_to_float_normed(pInSignal,
                        pInFrame,
                        FRAME_LEN);
    MfccColumn(&S_Mfcc, pInFrame, pOutColBuffer);

    for (uint32_t i = 0; i < NUM_MFCC; i++)
    {
        if (!isfinite(pOutColBuffer[i]))
        {
            // DebugUART_Log("[MFCC_ERR] static NaN i=%lu\r\n", i);
            memset(pOutMfccFrame, 0, MFCC_FEATURES * sizeof(float32_t));
            return;
        }
    }

    /*
     * Update MFCC history để tính delta và delta-delta.
     */
    history_idx = (history_idx + 1) % (DELTA_N + 1);

    memcpy(mfcc_history[history_idx],
           pOutColBuffer,
           NUM_MFCC * sizeof(float32_t));

    if (frames_seen < DELTA_N + 1)
    {
        frames_seen++;
    }

    float32_t delta[NUM_MFCC];
    float32_t delta_delta[NUM_MFCC];

    compute_delta_causal(mfcc_history,
                         history_idx,
                         frames_seen,
                         delta);

    memcpy(delta_history[history_idx],
           delta,
           NUM_MFCC * sizeof(float32_t));

    compute_delta_causal(delta_history,
                         history_idx,
                         frames_seen,
                         delta_delta);

    /*
     * Output shape mỗi frame = 39:
     * [0..12]   MFCC
     * [13..25]  delta
     * [26..38]  delta-delta
     */
    for (uint32_t i = 0; i < NUM_MFCC; i++)
    {
        pOutMfccFrame[i] = pOutColBuffer[i];
        pOutMfccFrame[NUM_MFCC + i] = delta[i];
        pOutMfccFrame[2 * NUM_MFCC + i] = delta_delta[i];
    }

    for (uint32_t i = 0; i < MFCC_FEATURES; i++)
    {
        if (!isfinite(pOutMfccFrame[i]))
        {
            // DebugUART_Log("[MFCC_ERR] final feature NaN i=%lu\r\n", i);
            memset(pOutMfccFrame, 0, MFCC_FEATURES * sizeof(float32_t));
            return;
        }
    }
}

void compute_mfcc_one_frame_timed(int16_t *audio_frame, float *mfcc_frame)
{
    uint32_t t0 = HAL_GetTick();

    compute_mfcc_one_frame(audio_frame, mfcc_frame);

    uint32_t dt = HAL_GetTick() - t0;

    mfcc_time_total_ms += dt;

    if (dt > mfcc_time_max_ms)
    {
        mfcc_time_max_ms = dt;
    }

    mfcc_frame_count++;

    static uint32_t last_log_ms = 0;
    uint32_t now = HAL_GetTick();

    if (now - last_log_ms >= 500)
    {
        last_log_ms = now;

        // DebugUART_Log(
        //     "[MFCC_FRAME] dt=%lu ms mfcc=[%.3f %.3f %.3f] delta=[%.3f] delta2=[%.3f]\r\n",
        //     dt,
        //     mfcc_frame[0],
        //     mfcc_frame[1],
        //     mfcc_frame[2],
        //     mfcc_frame[13],
        //     mfcc_frame[26]);
    }
}

void MFCC_DebugLog_Window(void)
{
    // uint32_t window_time = HAL_GetTick() - mfcc_window_start_ms;

    uint32_t avg = 0;
    if (mfcc_frame_count > 0)
    {
        avg = mfcc_time_total_ms / mfcc_frame_count;
    }

    DebugUART_Log(
        "[MFCC] audio_window=%lu ms, model_frames=%lu, new_frames=%lu, avg=%lu ms, max=%lu ms\r\n",
        4995UL,
        MFCC_TIME_FRAMES,
        mfcc_frame_count,
        avg,
        mfcc_time_max_ms);
}

void MFCC_DebugReset_Window(void)
{
    mfcc_frame_count = 0;
    mfcc_time_total_ms = 0;
    mfcc_time_max_ms = 0;
    mfcc_window_start_ms = HAL_GetTick();
}
/* =========================================================================
 * mfcc_append_frame
 *
 * Append 1 frame mới vào ma trận mfcc_final_features[39][333].
 * Dùng sliding window: shift trái, ghi cột mới vào cuối.
 * Khớp với T_FIXED=333 frame trong Python.
 * ========================================================================= */
void mfcc_append_frame(float *new_frame)
{
    if (mfcc_collected < MFCC_TIME_FRAMES)
    {
        for (uint32_t i = 0; i < MFCC_FEATURES; i++)
        {
            mfcc_final_features[i][mfcc_collected] = new_frame[i];
        }

        mfcc_collected++;
    }
    else
    {
        for (uint32_t i = 0; i < MFCC_FEATURES; i++)
        {
            memmove(&mfcc_final_features[i][0],
                    &mfcc_final_features[i][1],
                    (MFCC_TIME_FRAMES - 1) * sizeof(float));

            mfcc_final_features[i][MFCC_TIME_FRAMES - 1] = new_frame[i];
        }
    }
}