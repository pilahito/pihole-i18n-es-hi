# Marian NMT / OPUS-MT Models

Marian NMT is the engine behind many high-quality open translation models (including OPUS-MT).

## Popular models for Spanish and Hindi

| Direction | Model (Hugging Face)                  | Notes                    |
|-----------|---------------------------------------|--------------------------|
| en → es   | `Helsinki-NLP/opus-mt-en-es`          | Very good quality        |
| en → hi   | `Helsinki-NLP/opus-mt-en-hi`          | Available                |
| es → en   | `Helsinki-NLP/opus-mt-es-en`          | Useful for reverse       |
| hi → en   | `Helsinki-NLP/opus-mt-hi-en`          | Useful for reverse       |

## Using with CTranslate2 (recommended)

Convert once:
```bash
ct2-transformers-converter \
  --model Helsinki-NLP/opus-mt-en-es \
  --output_dir models/en-es \
  --quantization int8 \
  --force
```

Then use `tools/translate_ctranslate2.py`.

## Direct usage with transformers (higher RAM)

```python
from transformers import MarianMTModel, MarianTokenizer

model_name = "Helsinki-NLP/opus-mt-en-es"
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)

def translate(text):
    inputs = tokenizer(text, return_tensors="pt", padding=True)
    translated = model.generate(**inputs)
    return tokenizer.decode(translated[0], skip_special_tokens=True)

print(translate("Dashboard"))
```

## Advantages of Marian / OPUS-MT
- Often better quality than Argos for some language pairs
- Actively maintained by Helsinki-NLP
- Easy to quantize with CTranslate2 for low RAM
