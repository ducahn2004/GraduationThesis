/*
 * debug_uart.c
 *
 *  Created on: May 7, 2026
 *      Author: edoph
 */

#include "debug_uart.h"
#include <stdio.h>
#include <string.h>
#include <stdarg.h>

extern UART_HandleTypeDef huart3;

static uint32_t debug_start_tick = 0;

void DebugUART_InitTime(void)
{
    debug_start_tick = HAL_GetTick();
}

void DebugUART_Log(const char *fmt, ...)
{
    char msg[160];
    char out[220];
    va_list args;

    uint32_t now = HAL_GetTick() - debug_start_tick;

    va_start(args, fmt);
    vsnprintf(msg, sizeof(msg), fmt, args);
    va_end(args);

    snprintf(out,
             sizeof(out),
             "[%lu.%03lus] %s",
             now / 1000,
             now % 1000,
             msg);

    HAL_UART_Transmit(&huart3,
                      (uint8_t*)out,
                      strlen(out),
                      HAL_MAX_DELAY);
}
