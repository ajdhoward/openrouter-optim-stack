# OpenRouter Optimisation Stack – Project Context

**Last updated:** 2025-08-05

## What is this repo?
A public, self‑contained deployment scaffold that:
* Maximises free‑tier usage of OpenRouter.ai
* Provides smart routing, caching, analytics, and multi‑model consensus
* Bundles a hybrid chat UI that exposes both LocalAI (offline) and OpenRouter‑hosted models
* Ships with a diagnostics branch for safe read‑only audits, and a main branch for full deployment

## Key Components
| Component | Role |
|-----------|------|
| **LiteLLM** | Proxy & budget/routing gateway |
| **Helicone** | Usage analytics & caching |
| **LocalAI** | Runs a quantised local GGUF model |
| **Flowise** | No‑code tool‑builder & RAG pipelines |
| **n8n** | Low‑code automation (e.g., auto‑add new models) |
| **openrouter‑web** | Chat UI for all models |
| **Caddy 2** | HTTPS reverse‑proxy with automatic TLS |

## Branches
* **main** – production installer (`scripts/install.sh`) + Docker stack  
* **diagnostics** – read‑only audits (`scripts/diagnostics.sh`) + CI lint only

## How ChatGPT should use this repo
1. Read `docs/CONTEXT.md` (this file) for high‑level scope.  
2. Parse `.ai/context.json` for machine‑readable metadata.  
3. Use the directory structure to locate install scripts, diagnostics, and configs before giving guidance or writing code.  
4. Never expose private secrets; all credentials go in `.env` or GitHub Secrets.

## Next steps for contributors
* Fork → add new services or models in `docker-compose.yml`.  
* Keep docs updated here when architectural changes occur.  
* Ensure PRs pass the `compose-lint` workflow.

---
