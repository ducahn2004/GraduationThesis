/*
 * audio_capture.c
 */

#include "stm32h7xx_hal.h"
#include "audio_capture.h"
#include "app_x-cube-ai.h"
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdarg.h>
#include "debug_uart.h"


extern I2S_HandleTypeDef hi2s1;
extern UART_HandleTypeDef huart3;

/* Audio buffers */
__attribute__((aligned(32)))
int16_t audio_bufferA[AUDIO_BUFFER_SIZE];
volatile int16_t *current_buffer = audio_bufferA;
volatile uint8_t audio_ready = 0;

int16_t ring_buffer[RING_BUFFER_SIZE] = {0};
volatile uint32_t rb_write = 0;
volatile uint32_t rb_read = 0;

volatile uint8_t dbg_audio_flag = 0;
int16_t dbg_audio_snapshot[64];

/* Debug counters */
volatile uint32_t dbg_i2s_half_count = 0;
volatile uint32_t dbg_i2s_full_count = 0;
volatile uint32_t dbg_ring_push_count = 0;
volatile uint32_t dbg_ring_overflow_count = 0;
volatile uint32_t dbg_audio_ready_count = 0;

/* Debug timing */
volatile uint32_t dbg_last_half_time_ms = 0;
volatile uint32_t dbg_last_full_time_ms = 0;
volatile uint32_t dbg_last_push_time_ms = 0;
volatile uint32_t dbg_last_rms_time_ms = 0;

/* Flags để log ngoài interrupt */
volatile uint8_t dbg_half_flag = 0;
volatile uint8_t dbg_full_flag = 0;
volatile uint8_t dbg_overflow_flag = 0;

static uint32_t dbg_last_log_ms = 0;
static uint32_t boot_tick = 0;

volatile uint8_t dbg_ring_audio_flag = 0;
int16_t dbg_ring_audio_snapshot[64];
volatile uint32_t dbg_ring_audio_count = 0;


/* Private function prototypes */
//static uint32_t RingBuffer_Used(void);
static void audio_push_to_ring(int16_t *data, uint32_t len);
static void Audio_InvalidateDCache(void *addr, uint32_t size_bytes)
{
    uint32_t start = (uint32_t)addr;
    uint32_t end   = start + size_bytes;

    start &= ~31U;
    end = (end + 31U) & ~31U;

    SCB_InvalidateDCache_by_Addr((uint32_t *)start, end - start);
}
/*
 * Gọi hàm này trong while(1)
 */
void Audio_DebugLog_Process(void)
{
    uint32_t now = HAL_GetTick();

    if (dbg_half_flag)
    {
        dbg_half_flag = 0;
    }

    if (dbg_full_flag)
    {
        dbg_full_flag = 0;
    }

    if (dbg_overflow_flag)
    {
        dbg_overflow_flag = 0;
        // DebugUART_Log("[RING_ERR] overflow=%lu rb_w=%lu rb_r=%lu used=%lu\r\n",
        //               dbg_ring_overflow_count,
        //               rb_write,
        //               rb_read,
        //               RingBuffer_Used());
    }

    /* Log tổng mỗi 1 giây */
    /* Trong Audio_DebugLog_Process(), thay khối log 1 giây thành: */
    if (now - dbg_last_log_ms >= 1000)
    {
        dbg_last_log_ms = now;

        // DebugUART_Log(
        //     "[AUDIO] used=%lu smp (%.3f s) | push_time=%lu us | overflow=%lu\r\n",
        //     RingBuffer_Used(),
        //     (float)RingBuffer_Used() / 2000.0f,
        //     dbg_last_push_time_ms * 1000, /* ms → approximate µs nếu cần tick thực */
        //     dbg_ring_overflow_count);
    }

    static uint32_t dbg_last_ring_audio_log_ms = 0;

    if (dbg_ring_audio_flag && (now - dbg_last_ring_audio_log_ms >= 200))
    {
        dbg_ring_audio_flag = 0;
        dbg_last_ring_audio_log_ms = now;

        //Audio_DebugSamples(dbg_ring_audio_snapshot, dbg_ring_audio_count);
    }
}

uint32_t RingBuffer_Available(void)
{
    if (rb_write >= rb_read)
        return rb_write - rb_read;
    else
        return RING_BUFFER_SIZE - rb_read + rb_write;
}

uint8_t RingBuffer_Read(int16_t *out, uint32_t len)
{
    if (RingBuffer_Available() < len)
        return 0;

    for (uint32_t i = 0; i < len; i++)
    {
        out[i] = ring_buffer[rb_read];
        rb_read = (rb_read + 1) % RING_BUFFER_SIZE;
    }

    return 1;
}
/* Tính số sample đang có trong ring buffer */
// static uint32_t RingBuffer_Used(void)
// {
//     if (rb_write >= rb_read)
//         return rb_write - rb_read;
//     else
//         return RING_BUFFER_SIZE - rb_read + rb_write;
// }
void RingBuffer_Flush(void)
{
    rb_read = rb_write;
}
void StartAudioCapture(void)
{
    boot_tick = HAL_GetTick();

    DebugUART_Log("\r\n[AUDIO] Start capture\r\n");

    HAL_StatusTypeDef st;

    st = HAL_I2S_Receive_DMA(&hi2s1,
                             (uint16_t *)audio_bufferA,
                             AUDIO_BUFFER_SIZE);

    if (st == HAL_OK)
        DebugUART_Log("[AUDIO] I2S DMA started OK\r\n");
    else
        DebugUART_Log("[AUDIO_ERR] I2S DMA start failed, status=%d\r\n", st);

    DebugUART_Log("[AUDIO] Capture init done\r\n");
}

/*
 * Downsample 48kHz -> 2kHz
 */
static void audio_push_to_ring(int16_t *data, uint32_t len)
{
    uint32_t t0 = HAL_GetTick();
    uint32_t snap_count = 0;

    for (uint32_t i = MONO_CHANNEL_INDEX;
         i < len;
         i += DOWNSAMPLE_RATIO * AUDIO_CHANNELS)
    {
        int16_t sample = data[i];

        if (snap_count < 64)
        {
            dbg_ring_audio_snapshot[snap_count++] = sample;
        }

        uint32_t next = (rb_write + 1) % RING_BUFFER_SIZE;

        if (next == rb_read)
        {
            dbg_ring_overflow_count++;
            dbg_overflow_flag = 1;
            break;
        }

        ring_buffer[rb_write] = sample;
        rb_write = next;
        dbg_ring_push_count++;
    }

    dbg_ring_audio_count = snap_count;
    dbg_ring_audio_flag = 1;

    dbg_last_push_time_ms = HAL_GetTick() - t0;
}

/* Half-callback: không log UART trực tiếp trong interrupt */
void HAL_I2S_RxHalfCpltCallback(I2S_HandleTypeDef *hi2s)
{
    uint32_t t0 = HAL_GetTick();

    if (hi2s->Instance == SPI1)
    {
        dbg_i2s_half_count++;

        Audio_InvalidateDCache(
            audio_bufferA,
            (AUDIO_BUFFER_SIZE / 2) * sizeof(int16_t)
        );

        audio_push_to_ring(audio_bufferA, AUDIO_BUFFER_SIZE / 2);

        audio_ready = 1;
        dbg_audio_ready_count++;
        dbg_half_flag = 1;
    }

    dbg_last_half_time_ms = HAL_GetTick() - t0;
}

/* Full-callback: không log UART trực tiếp trong interrupt */
void HAL_I2S_RxCpltCallback(I2S_HandleTypeDef *hi2s)
{
    uint32_t t0 = HAL_GetTick();

    if (hi2s->Instance == SPI1)
    {
        dbg_i2s_full_count++;

        Audio_InvalidateDCache(
            &audio_bufferA[AUDIO_BUFFER_SIZE / 2],
            (AUDIO_BUFFER_SIZE / 2) * sizeof(int16_t)
        );

        audio_push_to_ring(&audio_bufferA[AUDIO_BUFFER_SIZE / 2],
                           AUDIO_BUFFER_SIZE / 2);

        audio_ready = 1;
        dbg_audio_ready_count++;
        dbg_full_flag = 1;
    }

    dbg_last_full_time_ms = HAL_GetTick() - t0;
}
