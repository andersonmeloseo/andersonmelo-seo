# Architecture

`andersonmelo-seo` is a Claude Code plugin: one orchestrator skill that routes to nine
specialist sub-skills, sharing two reference files. The design encodes how a senior SEO
consultant thinks — diagnose first, build second, and never guess a number.

## The loading model

Skills use progressive disclosure. Claude always sees each skill's **name + description**
(the triggering layer). When a skill triggers, its **SKILL.md body** loads. The shared
**references** load only when a skill needs them.

```
seo (orchestrator)              ← identity, 2 modes, priority sequence, routing
├── references/
│   ├── padroes-de-producao.md  ← HTML5, editorial, performance, ratings integrity, checklist
│   └── metodologias.md         ← Koray · Dixon Jones · Slawski · QRG — which lens for which problem
│
├── DIAGNOSE
│   ├── seo-auditoria           ← 9-layer audit → weighted health score → prioritized plan
│   ├── seo-topical             ← topical maps, clusters, entities, intent coverage
│   ├── seo-on-page             ← single-URL on-page + content briefs
│   ├── seo-geo                 ← GEO/AEO/LLMO citability
│   └── seo-backlinks           ← backlink profile & authority (free-tier or paid)
│
└── BUILD
    ├── seo-programmatic        ← pages at scale with anti-thin safeguards
    ├── seo-schema              ← JSON-LD @graph, knowledge graph, ratings integrity
    ├── seo-semantic-html       ← semantic HTML5 + Core Web Vitals + a11y
    ├── seo-local-rank-and-rent ← local SEO + rank-and-rent playbook
    └── seo-hreflang            ← international SEO (hreflang audit + generation)
```

## The two modes (the core principle)

Every skill declares which mode it is in:

- **Execution** — data or a reachable URL is available. Real analysis, cited evidence,
  quantified findings.
- **Framework** — data is missing. The method, what to collect, and what each finding would
  mean — but never a fabricated number.

This is the line that separates the plugin from tools that hallucinate metrics.

## Routing

The orchestrator maps user intent to a command and a sub-skill (see the table in
`skills/seo/SKILL.md`). Most real work crosses skills — a full audit touches almost all of
them; a programmatic portal combines `seo-topical` + `seo-programmatic` + `seo-schema` +
`seo-semantic-html` + `seo-geo`. Claude loads the ones the job needs.

## Priority sequence

Effort spent out of order is wasted. The orchestrator enforces an order: technical
foundation → architecture & intent → on-page & content → authority (entity & off-page) →
GEO/AEO. Chasing AI-search citations on a site that does not rank organically is premature.

## Methodologies

The plugin applies the right lens to each problem: **Koray Tuğberk Gübür** (topical
authority), **Dixon Jones** (knowledge graph, entities), **Bill Slawski** (IR / Google
patents), and the **Search Quality Rater Guidelines** as the quality bar. See
`skills/seo/references/metodologias.md`.
