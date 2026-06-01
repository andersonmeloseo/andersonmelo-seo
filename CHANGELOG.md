# Changelog

Todas as mudanças relevantes deste projeto são documentadas aqui.
O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/)
e o versionamento segue [SemVer](https://semver.org/lang/pt-BR/).

## [Não lançado]

### Adicionado
- Estrutura inicial do plugin: orquestrador `seo` + 8 sub-skills.
- Skills de diagnóstico: `seo-auditoria`, `seo-topical`, `seo-on-page`, `seo-geo`.
- Skills de construção: `seo-programmatic`, `seo-schema`, `seo-semantic-html`, `seo-local-rank-and-rent`.
- Referência compartilhada de padrões de produção.
- Instalador manual (`install.sh`/`uninstall.sh`) como fallback ao `/plugin`.

## [0.3.0] — 2026-06

### Adicionado
- Nova sub-skill **`seo-backlinks`**: análise de perfil de links e autoridade off-page com método de free-tier (GSC, Bing Webmaster, Common Crawl) ou dados pagos quando fornecidos — preenche a zona cega de backlinks que os auditores apontavam. Nunca estima DA/DR sem fonte.
- `docs/QUICKSTART.md`: guia de teste com prompts copia-e-cola.

## [0.2.0] — 2026-06

### Adicionado
- **Subagents de auditoria** (`agents/`): `seo-auditor-tecnico`, `seo-auditor-conteudo`, `seo-auditor-schema`, `seo-auditor-geo`, `seo-auditor-arquitetura`. A skill `seo-auditoria` os dispara em paralelo (mais rápido e profundo em sites grandes); cada um devolve achados evidência->impacto->esforço->prioridade + nota 0-100 da sua dimensão.
- Vitrine e rigor de repo: banner SVG, social preview card, `docs/ARCHITECTURE.md`, `CONTRIBUTING.md`, CI de validação (`scripts/validate.py` + GitHub Actions) e templates de issue/PR.

## [0.1.1] — 2026-06

### Corrigido
- Métricas/thresholds apresentados como oficiais do Google foram rotulados como heurística desta skill ou substituídos por critério qualitativo (auditoria, programmatic, topical) — alinha com a promessa de nunca apresentar estimativa como fato.
- Bugs técnicos: `speakable` via JSON-LD (não microdata); INP definido como P98 de todas as interações (não FID); preload de imagem com `type`; LCP rotulado (lab 2,0s vs campo 2,5s); limite de title corrigido (~580px / 50-60 chars).
- Atualizações factuais de AI Search (Gemini, llms.txt, FAQ, IndexNow) em seo-geo.
- Atribuições corrigidas (Dixon Jones = knowledge graph/entidades, não topical authority); `search_intent` removido do nível de macro-silo.
- `seo-semantic-html` enxugada (menos duplicação com os padrões compartilhados).

## [0.1.0] — 2026-06

Primeira versão pública.
