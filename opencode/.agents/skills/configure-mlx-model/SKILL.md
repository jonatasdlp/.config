---
name: configure-mlx-model
description: Configure new MLX models in opencode.json for local inference. Use when the user wants to add, update, or configure MLX LM providers and models in their opencode configuration. Triggers on requests involving: mlx model setup, local model configuration, adding new MLX models, configuring model providers, or opencode.json model entries.
---

# Configure MLX Model

Guide for adding MLX models to opencode.json with correct provider configuration.

## Rules

1. **Provider structure**: All providers use `"@ai-sdk/openai-compatible"` npm package
2. **MLX endpoint**: `baseURL` must be `"http://localhost:8080/v1"`
3. **Model naming**: Use full HuggingFace path (e.g., `mlx-community/gemma-4-e4b-it-qat-OptiQ-4bit`)
4. **Provider name prefix**: Use descriptive names like `mlx-lm`, `mlx`, `mlx-coder`

## Steps

### 1. Add new model to existing MLX provider

Add entry under `provider.<name>.models`:

```json
"mlx-community/MODEL-NAME": {
  "name": "mlx-community/MODEL-NAME"
}
```

### 2. Create new MLX provider (if needed)

Add new provider object:

```json
"provider-name": {
  "npm": "@ai-sdk/openai-compatible",
  "name": "Human-readable name",
  "options": {
    "baseURL": "http://localhost:8080/v1"
  },
  "models": {
    "model-id": {
      "name": "model-id"
    }
  }
}
```

### 3. Set default model (optional)

Update top-level `model` field to `"provider-name/model-id"`.

## Validation Checklist

After editing, verify:
- [ ] JSON is valid (no trailing commas)
- [ ] Provider uses correct `npm` package
- [ ] `baseURL` is exactly `http://localhost:8080/v1`
- [ ] Model ID matches HuggingFace MLX community format
- [ ] Provider name is descriptive and unique
- [ ] Top-level `model` references exist if changed

## Common Patterns

See [references/mlx-config-template.json](references/mlx-config-template.json) for complete working examples based on the user's current configuration, including:
- MLX LM provider with multiple models
- Ollama-compatible providers for comparison
- Default model configuration
- Model naming conventions for quantized models (QAT, 4bit, etc.)
