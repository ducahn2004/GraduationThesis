/**
 ******************************************************************************
 * @file    mfcc_example.c
 * @author  MCD Application Team
 * @brief   MFCC computation example
 ******************************************************************************
 * @attention
 *
 * <h2><center>&copy; Copyright (c) 2019 STMicroelectronics.
 * All rights reserved.</center></h2>
 *
 * This software component is licensed by ST under Software License Agreement
 * SLA0055, the "License"; You may not use this file except in compliance with
 * the License. You may obtain a copy of the License at:
 *        www.st.com/resource/en/license_agreement/dm00251784.pdf
 *
 ******************************************************************************
 */

#ifndef MFCCE_XTRACT_H
#define MFCCE_XTRACT_H


#include "feature_extraction.h"
#include "arm_math.h"

#define MFCC_FEATURES       39U
#define MFCC_TIME_FRAMES    333U
#define MFCC_TOTAL_SIZE (MFCC_FEATURES * MFCC_TIME_FRAMES)

#define SAMPLE_RATE PROC_SAMPLE_RATE
#define HOP_LEN HOP_SAMPLES
#define FFT_LEN 256U
#define NUM_MFCC 13U
#define NUM_MFCC_TOTAL (NUM_MFCC * 3) // 39
#define NUM_MELS 64U
#define NUM_STAGES 2 // Bậc 4 Butterworth = 2 tầng Biquad

#define MAX_MEL_COEFS 8192U

extern float32_t mfcc_final_features[39][333];
extern uint32_t mfcc_collected;
extern void compute_mfcc_one_frame(int16_t *frame, float *out_39);
extern void mfcc_append_frame(float *new_frame);
extern uint32_t mfcc_frame_count;
extern uint32_t mfcc_time_total_ms;
extern uint32_t mfcc_time_max_ms;
extern uint32_t mfcc_window_start_ms;


/* =====================================================================
 * Thông số phù hợp với PhysioNet 2016 + model input 1×39×333
 * ===================================================================== */

void Preprocessing_Init(void);
void AudioPreprocessing_Run(int16_t *pInSignal, float32_t *pOutMfcc, uint32_t signal_len);
void compute_mfcc_one_frame_timed(int16_t *audio_frame, float *mfcc_frame);
void MFCC_DebugLog_Window(void);
void MFCC_DebugReset_Window(void);

#endif /* MFCCE_XTRACT_H */
