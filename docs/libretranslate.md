# LibreTranslate local setup (optimized for low RAM)

## Docker (recommended)

```bash
docker run -d \
  --name libretranslate \
  --memory=1.2g \
  --memory-swap=1.8g \
  -p 5000:5000 \
  -v ~/libretranslate/data:/home/libretranslate/db \
  -e LT_LOAD_ONLY=en,es,hi \
  -e LT_UPDATE_MODELS=false \
  -e LT_THREADS=1 \
  -e ARGOS_COMPUTE_TYPE=int8 \
  -e ARGOS_INTER_THREADS=1 \
  -e ARGOS_INTRA_THREADS=1 \
  -e ARGOS_BEAM_SIZE=1 \
  -e OMP_NUM_THREADS=1 \
  libretranslate/libretranslate
```

## Test

```bash
curl -X POST http://localhost:5000/translate \
  -H "Content-Type: application/json" \
  -d '{"q":"Dashboard","source":"en","target":"es"}'
```

Then run:
```bash
python tools/translate.py
```
