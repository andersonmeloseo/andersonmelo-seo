<div align="center">

<img src="assets/banner.svg" alt="andersonmelo-seo — SEO de elite para Claude Code" width="100%">

# andersonmelo-seo

### An elite SEO plugin for Claude Code — a senior consultant that *audits* and *builds*.

[![Version](https://img.shields.io/badge/version-0.3.0-blue)](./CHANGELOG.md)
[![validate](https://github.com/andersonmeloseo/andersonmelo-seo/actions/workflows/validate.yml/badge.svg)](https://github.com/andersonmeloseo/andersonmelo-seo/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](./LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-7c3aed)](https://docs.claude.com/en/docs/claude-code)
[![Made in](https://img.shields.io/badge/feito%20no-Brasil%20%F0%9F%87%A7%F0%9F%87%B7-009c3b)](https://andersonmeloseo.com.br)

**Topical authority · Knowledge graph & entities · Information Gain · Programmatic SEO at scale · Local rank-and-rent · Semantic HTML5 · Schema/JSON-LD · Core Web Vitals · GEO/AEO/LLMO**

</div>

---

> **Note for English readers:** the skills are written in **Portuguese (PT-BR)**, tuned for the Brazilian SEO market. The methodology is universal — Claude executes the skills in whatever language you talk to it. This README is in English for discovery.

## What this is

`andersonmelo-seo` turns Claude Code into a **senior SEO/GEO/AEO consultant** that does two jobs most tools split apart:

- **Diagnoses** — audits a site or URL across nine layers, finds what's wrong, and ranks fixes by evidence → impact → effort → priority.
- **Builds** — architects topical authority, generates programmatic pages at scale *without* tripping the thin-content red line, writes semantic HTML5, and marks up a real knowledge graph.

It's built on the methodologies of **Koray Tuğberk Gübür** (topical authority, semantic SEO), **Dixon Jones** (knowledge graph, entities, `sameAs`) and **Bill Slawski** (Google patents, information retrieval), with 2026 AI-Search practice on top.

### Why it's different from generic SEO tools

| | Tooling-first plugins | **andersonmelo-seo** |
|---|---|---|
| Core bet | APIs, crawls, scripts | **Senior strategist methodology** |
| Posture | Reports data | **Audits *and* builds** |
| Data discipline | Often guesses | **Two modes — never hallucinates a metric** |
| Programmatic | Generates volume | **Volume only with Information Gain per page** |
| Ratings/schema | "Add aggregateRating" | **Ratings integrity — markup you'd defend in a manual Google review** |

### The non-negotiable: data before diagnosis

Every skill operates in one of two declared modes:

- **Execution mode** — there's data or a reachable URL. It analyzes for real, cites evidence, quantifies.
- **Framework mode** — data is missing. It delivers the method, what to collect and how — and **never presents an estimate as a measurement.**

## The skills

One orchestrator (`/seo`) routes to nine specialists, grouped by the two jobs:

### 🔍 Diagnose
| Skill | What it does |
|---|---|
| **seo-auditoria** | Full site/URL audit across 9 layers → 0–100 health score + prioritized action plan |
| **seo-topical** | Topical authority architecture: entity-first topical maps, clusters, intent coverage |
| **seo-on-page** | Single-URL on-page optimization + competitive content briefs |
| **seo-geo** | GEO/AEO/LLMO: citability for AI Overviews, ChatGPT, Perplexity, Gemini, Claude |
| **seo-backlinks** | Backlink profile, referring domains, anchor text, link gap — free-tier (GSC/Bing/Common Crawl) or paid |

### 🏗️ Build
| Skill | What it does |
|---|---|
| **seo-programmatic** | Pages at scale, dataset-driven, with anti-thin / near-duplicate safeguards |
| **seo-schema** | Schema/JSON-LD `@graph`, knowledge graph, ratings integrity |
| **seo-semantic-html** | Semantic HTML5 + Core Web Vitals in the markup + Lighthouse 100 + a11y |
| **seo-local-rank-and-rent** | Local SEO (GBP, NAP, citations) + the rank-and-rent / lead-gen playbook |

### ⚙️ Parallel audit

`seo-auditoria` fans out to five specialist subagents — **técnico · conteúdo · schema · geo · arquitetura** — for fast, deep audits of large sites. Each returns findings as evidence → impact → effort → priority, aggregated into the health score.

## Install

### Recommended — native plugin (Claude Code)

```
/plugin marketplace add andersonmeloseo/andersonmelo-seo
/plugin install andersonmelo-seo@andersonmelo-seo
```

Via `/plugin`, the skills are namespaced and won't collide with other SEO plugins.

### Manual (fallback when `/plugin` isn't available in your environment)

```bash
git clone --depth 1 https://github.com/andersonmeloseo/andersonmelo-seo.git
bash andersonmelo-seo/install.sh
```

This copies the skills into `~/.claude/skills/` and any agents into `~/.claude/agents/` — the locations Claude Code reads natively. Uninstall with `bash andersonmelo-seo/uninstall.sh`.

## Usage

```
/seo auditoria https://exemplo.com        # full audit + health score + action plan
/seo topical "consultoria tributária"      # topical map for a niche
/seo on-page https://exemplo.com/artigo/   # on-page analysis or content brief
/seo schema https://exemplo.com            # detect/validate/generate JSON-LD
/seo programmatic plano                     # plan pages at scale (dataset-driven)
/seo geo https://exemplo.com               # AI-search citability
/seo local "encanador São Paulo"           # local SEO / rank-and-rent
```

You don't have to name the command. Ask naturally — *"por que minha página não rankeia?"*, *"como apareço no ChatGPT?"*, *"monta a arquitetura de um portal de cidades"* — and the orchestrator routes you to the right specialist.

## Methodology

The plugin doesn't just run checks — it applies the right lens to each problem:

- **Koray Tuğberk Gübür** → topical maps, coverage, depth before breadth
- **Dixon Jones** → the site as an entity graph, `sameAs`, brand consolidation
- **Bill Slawski** → IR-grounded decisions, not folklore
- **Google QRG (Sept 2025)** → E-E-A-T and the scaled-content-abuse red line

See [`skills/seo/references/metodologias.md`](./skills/seo/references/metodologias.md) and the shared production standards in [`skills/seo/references/padroes-de-producao.md`](./skills/seo/references/padroes-de-producao.md).

## Author

Built by **[Anderson Melo](https://andersonmeloseo.com.br)** — SEO consultant (Octa SEO / GO Everest), focused on programmatic SEO, local SEO and rank-and-rent across Brazil, the US and Spain.

- 🌐 [andersonmeloseo.com.br](https://andersonmeloseo.com.br)
- 💼 Consultoria de SEO programático, Local SEO e GEO

If this plugin helps you, a ⭐ on the repo helps it reach more people.

## Contributing

Issues and PRs are welcome — especially SEO corrections backed by a source. See
[CONTRIBUTING.md](./CONTRIBUTING.md) and the [architecture overview](./docs/ARCHITECTURE.md).
The one rule: never present an estimate as a measurement.

## License

[MIT](./LICENSE) © 2026 Anderson Melo
