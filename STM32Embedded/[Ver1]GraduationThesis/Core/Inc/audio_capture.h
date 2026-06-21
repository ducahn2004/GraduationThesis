/*
 * audio_capture.h
 *
 *  Created on: Feb 8, 2026
 *      Author: edoph
 */

#ifndef INC_AUDIO_CAPTURE_H_
#define INC_AUDIO_CAPTURE_H_

#include "stm32h7xx_hal.h"
#include "arm_math.h"

/* =========================================================================
 * Sample rate config
 *   I2S hardware  : 48000 Hz
 *   Processing fs : 4000 Hz  (khớp physionet dataset + Python training)
 *   Downsample    : 48000 / 4000 = 12
 * ========================================================================= */
#define I2S_SAMPLE_RATE      48000U
#define PROC_SAMPLE_RATE     4000U
#define DOWNSAMPLE_RATIO     (I2S_SAMPLE_RATE / PROC_SAMPLE_RATE)   // = 12

/* =========================================================================
 * Frame / hop — tính tại PROC_SAMPLE_RATE = 4000 Hz
 *   FRAME_LEN_MS = 25 ms → 25 * 4000 / 1000 = 100 samples
 *   HOP_LEN_MS   = 15 ms → 15 * 4000 / 1000 = 60 samples
 *
 * Trong ring buffer (đã downsample), mỗi hop = 60 samples @4kHz.
 * Từ I2S (48kHz) mỗi hop tương ứng = 60 * 12 = 720 raw samples.
 * ========================================================================= */
#define FRAME_LEN_MS         25U
#define HOP_LEN_MS           15U
#define FRAME_LEN            ((PROC_SAMPLE_RATE * FRAME_LEN_MS) / 1000U)   // = 1000
#define HOP_SAMPLES          ((PROC_SAMPLE_RATE * HOP_LEN_MS)   / 1000U)   // = 60

/* =========================================================================
 * DMA audio buffer (raw 48kHz)
 *   Mỗi half-callback nhận 720 raw samples → downsample → 30 samples @2kHz
 *   AUDIO_BUFFER_SIZE = 2 * 720 = 1440  (half + full)
 * ========================================================================= */
#define AUDIO_CHANNELS 2
#define MONO_CHANNEL_INDEX 0
#define AUDIO_HALF_RAW       (HOP_SAMPLES * DOWNSAMPLE_RATIO * AUDIO_CHANNELS) // = 1440
#define AUDIO_BUFFER_SIZE    (AUDIO_HALF_RAW * 2)                          // = 2880

/* =========================================================================
 * Ring buffer — lưu dữ liệu đã downsample @2kHz
 *   Cần đủ cho vài giây buffer, 2000 Hz * 5s = 10000 samples
 * ========================================================================= */
#define RING_BUFFER_SIZE     24000U

/* =========================================================================
 * Exports
 * ========================================================================= */
extern int16_t           audio_bufferA[AUDIO_BUFFER_SIZE];
extern volatile int16_t* current_buffer;
extern volatile uint8_t  audio_ready;

extern int16_t           ring_buffer[RING_BUFFER_SIZE];
extern volatile uint32_t rb_write;
extern volatile uint32_t rb_read;


extern volatile uint32_t dbg_i2s_half_count;
extern volatile uint32_t dbg_i2s_full_count;
extern volatile uint32_t dbg_ring_push_count;
extern volatile uint32_t dbg_ring_overflow_count;
extern volatile uint32_t dbg_audio_ready_count;
/* =========================================================================
 * Function prototypes
 * ========================================================================= */
void StartAudioCapture(void);
void Audio_DebugLog_Process(void);

uint32_t RingBuffer_Available(void);
uint8_t  RingBuffer_Read(int16_t *out, uint32_t len);
void     RingBuffer_Flush(void);  
#endif /* INC_AUDIO_CAPTURE_H_ */