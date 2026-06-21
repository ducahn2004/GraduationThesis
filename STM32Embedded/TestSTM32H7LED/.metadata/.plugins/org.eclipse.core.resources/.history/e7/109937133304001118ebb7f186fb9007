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
#include "feature_extraction.h"

/*
 * y = librosa.load('bus.wav', sr=None, duration=1)[0] # Keep native 16kHz sampling rate
 * librosa.feature.mfcc(y, sr=16000, n_mfcc=20, dct_type=2, norm='ortho', lifter=0, center=False)
 */

#define SAMPLE_RATE  16000U /* Input signal sampling rate */
#define FFT_LEN       2048U /* Number of FFT points. Must be greater or equal to FRAME_LEN */
#define FRAME_LEN   FFT_LEN /* Window length and then padded with zeros to match FFT_LEN */
#define HOP_LEN        512U /* Number of overlapping samples between successive frames */
#define NUM_MELS       128U /* Number of mel bands */
#define NUM_MEL_COEFS 2020U /* Number of mel filter weights. Returned by MelFilterbank_Init */
#define NUM_MFCC        20U /* Number of MFCCs to return */

void Preprocessing_Init(void);
void AudioPreprocessing_Run(int16_t *pInSignal, float32_t *pOutMfcc, uint32_t signal_len);
