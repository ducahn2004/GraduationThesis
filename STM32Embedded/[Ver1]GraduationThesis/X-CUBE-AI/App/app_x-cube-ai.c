
/**
 ******************************************************************************
 * @file    app_x-cube-ai.c
 * @author  X-CUBE-AI C code generator
 * @brief   AI program body
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2026 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */

/*
 * Description
 *   v1.0 - Minimum template to show how to use the Embedded Client API
 *          model. Only one input and one output is supported. All
 *          memory resources are allocated statically (AI_NETWORK_XX, defines
 *          are used).
 *          Re-target of the printf function is out-of-scope.
 *   v2.0 - add multiple IO and/or multiple heap support
 *
 *   For more information, see the embeded documentation:
 *
 *       [1] %X_CUBE_AI_DIR%/Documentation/index.html
 *
 *   X_CUBE_AI_DIR indicates the location where the X-CUBE-AI pack is installed
 *   typical : C:\Users\[user_name]\STM32Cube\Repository\STMicroelectronics\X-CUBE-AI\7.1.0
 */

#ifdef __cplusplus
extern "C"
{
#endif

  /* Includes ------------------------------------------------------------------*/

#if defined(__ICCARM__)
#elif defined(__CC_ARM) || (__GNUC__)
#endif

/* System headers */
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <inttypes.h>
#include <string.h>

#include "app_x-cube-ai.h"
#include "main.h"
#include "ai_datatypes_defines.h"
#include "network_4.h"
#include "network_4_data.h"
#include "mfcc_extract.h"
#include "debug_uart.h"

  extern UART_HandleTypeDef huart3;
/* USER CODE BEGIN includes */
#define ABNORMAL_LED_GPIO_Port GPIOA
#define ABNORMAL_LED_Pin GPIO_PIN_1
  /* USER CODE END includes */

  /* IO buffers ----------------------------------------------------------------*/

#if !defined(AI_NETWORK_4_INPUTS_IN_ACTIVATIONS)
  AI_ALIGNED(4)
  ai_i8 data_in_1[AI_NETWORK_4_IN_1_SIZE_BYTES];
  ai_i8 *data_ins[AI_NETWORK_4_IN_NUM] = {
      data_in_1};
#else
ai_i8 *data_ins[AI_NETWORK_4_IN_NUM] = {
    NULL};
#endif

#if !defined(AI_NETWORK_4_OUTPUTS_IN_ACTIVATIONS)
  AI_ALIGNED(4)
  ai_i8 data_out_1[AI_NETWORK_4_OUT_1_SIZE_BYTES];
  ai_i8 *data_outs[AI_NETWORK_4_OUT_NUM] = {
      data_out_1};
#else
ai_i8 *data_outs[AI_NETWORK_4_OUT_NUM] = {
    NULL};
#endif

  /* Activations buffers -------------------------------------------------------*/

  AI_ALIGNED(32)
  static uint8_t pool0[AI_NETWORK_4_DATA_ACTIVATION_1_SIZE];

  ai_handle data_activations0[] = {pool0};

  /* AI objects ----------------------------------------------------------------*/

  static ai_handle network_4 = AI_HANDLE_NULL;

  static ai_buffer *ai_input;
  static ai_buffer *ai_output;
  uint8_t classification_result = 0;

  static void ai_log_err(const ai_error err, const char *fct)
  {
    char msg[128];

    if (fct != NULL)
    {
      sprintf(msg,
              "[AI_ERR] %s type=0x%02x code=0x%02x\r\n",
              fct,
              err.type,
              err.code);
    }
    else
    {
      sprintf(msg,
              "[AI_ERR] type=0x%02x code=0x%02x\r\n",
              err.type,
              err.code);
    }

    DebugUART_Log(msg);
  }

  static int ai_boostrap(ai_handle *act_addr)
  {
    ai_error err;

    /* Create and initialize an instance of the model */
    err = ai_network_4_create_and_init(&network_4, act_addr, NULL);
    if (err.type != AI_ERROR_NONE)
    {
      ai_log_err(err, "ai_network_4_create_and_init");
      return -1;
    }

    ai_input = ai_network_4_inputs_get(network_4, NULL);
    ai_output = ai_network_4_outputs_get(network_4, NULL);

#if defined(AI_NETWORK_4_INPUTS_IN_ACTIVATIONS)
    /*  In the case where "--allocate-inputs" option is used, memory buffer can be
     *  used from the activations buffer. This is not mandatory.
     */
    for (int idx = 0; idx < AI_NETWORK_4_IN_NUM; idx++)
    {
      data_ins[idx] = ai_input[idx].data;
    }
#else
  for (int idx = 0; idx < AI_NETWORK_4_IN_NUM; idx++)
  {
    ai_input[idx].data = data_ins[idx];
  }
#endif

#if defined(AI_NETWORK_4_OUTPUTS_IN_ACTIVATIONS)
    /*  In the case where "--allocate-outputs" option is used, memory buffer can be
     *  used from the activations buffer. This is no mandatory.
     */
    for (int idx = 0; idx < AI_NETWORK_4_OUT_NUM; idx++)
    {
      data_outs[idx] = ai_output[idx].data;
    }
#else
  for (int idx = 0; idx < AI_NETWORK_4_OUT_NUM; idx++)
  {
    ai_output[idx].data = data_outs[idx];
  }
#endif

    return 0;
  }

  static int ai_run(void)
  {
    ai_i32 batch;

    batch = ai_network_4_run(network_4, ai_input, ai_output);
    if (batch != 1)
    {
      ai_log_err(ai_network_4_get_error(network_4),
                 "ai_network_4_run");
      return -1;
    }

    return 0;
  }

  /* USER CODE BEGIN 2 */
  int acquire_and_process_data(ai_i8 *data[])
  {
    // Copy float32 → ai_float (model dùng float32)
    ai_float *input_ptr = (ai_float *)data[0]; // Vì data_in_1 là ai_i8 nhưng model float32

    // Kiểm tra kích thước (phải khớp AI_NETWORK_4_IN_1_SIZE = 39*333*4 bytes)
    if (AI_NETWORK_4_IN_1_SIZE != (MFCC_FEATURES * MFCC_TIME_FRAMES))
    {
      DebugUART_Log("[AI_ERR] Input size mismatch!\r\n");

      return -1;
    }

    memcpy(input_ptr, &mfcc_final_features[0][0], MFCC_TIME_FRAMES * MFCC_FEATURES * sizeof(ai_float));

    return 0;
  }

  /**
   * @brief  Post-process output và điều khiển LED PA1
   * @param  data[]: buffer output của AI
   * @retval 0
   */
  int post_process(ai_i8 *data[])
  {
    ai_float *output_ptr = (ai_float *)data[0];

    float score_normal = output_ptr[0];
    float score_abnormal = output_ptr[1];

    classification_result = (score_abnormal > score_normal) ? 1 : 0;
    
    if (classification_result == 1)
    {
      HAL_GPIO_WritePin(ABNORMAL_LED_GPIO_Port,
                        ABNORMAL_LED_Pin,
                        GPIO_PIN_SET);

      DebugUART_Log("AI result: Abnormal\r\n");
    }
    else
    {
      HAL_GPIO_WritePin(ABNORMAL_LED_GPIO_Port,
                        ABNORMAL_LED_Pin,
                        GPIO_PIN_RESET);

      DebugUART_Log("AI result: Normal\r\n");
    }

    return 0;
  }
  /* USER CODE END 2 */

  /* Entry points --------------------------------------------------------------*/

  void MX_X_CUBE_AI_Init(void)
  {
    /* USER CODE BEGIN 5 */
    char msg[] = "\r\n[AI] Initialization\r\n";

    DebugUART_Log(msg);

    ai_boostrap(data_activations0);
    /* USER CODE END 5 */
  }

  void MX_X_CUBE_AI_Process(void)
  {
    int res = -1;

    uint32_t t_all0 = HAL_GetTick();

    DebugUART_Log("AI Run inference\r\n");

    if (network_4 == AI_HANDLE_NULL)
    {
      DebugUART_Log("AI network not initialized\r\n");
      return;
    }

    uint32_t t0 = HAL_GetTick();

    res = acquire_and_process_data(data_ins);

    uint32_t t1 = HAL_GetTick();

    if (res == 0)
    {
      res = ai_run();
    }

    uint32_t t2 = HAL_GetTick();

    if (res == 0)
    {
      res = post_process(data_outs);
    }

    uint32_t t3 = HAL_GetTick();

    if (res == 0)
    {
      DebugUART_Log("AI time copy=%lu ms, run=%lu ms, post=%lu ms, total=%lu ms\r\n",
                    t1 - t0,
                    t2 - t1,
                    t3 - t2,
                    t3 - t_all0);
    }
    else
    {
      ai_error err = {AI_ERROR_INVALID_STATE, AI_ERROR_CODE_NETWORK};
      ai_log_err(err, "Process has FAILED");
    }
  }
#ifdef __cplusplus
}
#endif
