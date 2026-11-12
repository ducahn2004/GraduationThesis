# TFLITE: Exported Model Artifacts

This folder holds the outputs of the *ConvertToTFLite* notebooks: pruned PyTorch checkpoints, ONNX graphs and TensorFlow Lite models, for every architecture and training run that was converted.

## Naming convention

```
<arch>_<MMDD>_<HHMMSS>_<stage>.<ext>
```

| Part | Meaning |
|---|---|
| `arch` | `light_cnn` (LightWeight CNN), `cnn` (simple CNN), `crnn`, `vgg11` |
| `MMDD_HHMMSS` | Timestamp of the training run. It matches the folder `Model/saved/<arch>/models/Physionet_<arch>/<timestamp>/`. |
| `_pruned_finetuned.pth` | PyTorch weights after 20 % L1 unstructured pruning and fine-tuning (masks removed) |
| `_final.onnx` (+ `.onnx.data`) | ONNX export (opset 17, static input `1 × 39 × 333`, logits output). `.onnx.data` holds external weights. |
| `_no_init_state.onnx`, `_fixed_init.onnx` | ONNX graphs patched for RNN models (CRNN), with the initial hidden state removed or fixed |
| `_final_simple.onnx`, `_final_fixed.onnx` | Graph simplified with `onnxsim` / patched for the converter |
| `_int8_quant.onnx`, `_static_int8.onnx` | ONNX-Runtime static INT8 quantization (QDQ) |
| `*_saved_model/`, `light_cnn_savedmodel/` | Intermediate TensorFlow SavedModel |
| `<arch>_tflite_int8_<timestamp>/` | `onnx2tf` / TFLiteConverter outputs (see below) |

### Contents of a `*_tflite_int8_*` folder

| File | Description |
|---|---|
| `*_final_float32.tflite` | Float32 model |
| `*_final_float16.tflite` | Float16 weights |
| `*_final_integer_quant.tflite` | INT8 weights and activations, **float32 I/O** |
| `*_final_full_integer_quant.tflite` | Full INT8 (I/O also INT8) |
| `*_with_int16_act.tflite` | INT8 weights + INT16 activations |
| `*_tensor_correspondence_report.json` | ONNX ↔ TFLite tensor mapping from `onnx2tf` |
| `schema.fbs`, `schema_generated.py` | TFLite flatbuffer schema, used to inspect or patch the model |

## Models used in the thesis

| Run | File | Used for |
|---|---|---|
| `light_cnn_0406_003729` | `light_cnn_tflite_int8_0406_003729/light_cnn_0406_003729_final_float32.tflite` | Imported into X-CUBE-AI as `network_4` (Flash 53.16 KiB, RAM 124.27 KiB) |
| `light_cnn_0406_135605` | `light_cnn_tflite_int8_0406_135605/*_integer_quant.tflite` (~22–23 KB) | INT8 model reported in the thesis (≈24.8 KB, Acc 84.88 %) |
| `light_cnn_0307_173933` | also copied into `STM32Embedded/[Ver1]GraduationThesis/LightCNN_0307_173933/` | Earlier on-device tests |

Older runs (`cnn_*`, `crnn_*`, `vgg11_*`, `light_cnn_02xx_*`) are kept for comparison.

## Inspecting a model

- **Netron** (<https://netron.app>): drag and drop any `.onnx` or `.tflite` file to view the graph.
- Python:

  ```python
  import tensorflow as tf
  it = tf.lite.Interpreter("light_cnn_0406_135605_final_integer_quant.tflite")
  it.allocate_tensors()
  print(it.get_input_details(), it.get_output_details())
  ```
- ST Edge AI:

  ```bash
  stedgeai analyze -m <model>.tflite --target stm32h7
  ```
