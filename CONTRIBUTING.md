# Contributing

Thanks for your interest in improving **andersonmelo-seo**. This plugin encodes a
senior-consultant SEO methodology — contributions are welcome as long as they hold the
bar the plugin sets for itself.

## The one non-negotiable rule

**Never present an estimate as a measurement.** Every skill operates in two modes:

- **Execution mode** — there is data or a reachable URL. Analyze for real, cite evidence, quantify.
- **Framework mode** — data is missing. Deliver the method and what to collect. Do **not** invent numbers.

If your contribution adds a fabricated threshold, statistic, or "the Google does X%" claim
without a verifiable source, it will be rejected. When a heuristic is useful, label it as a
heuristic of this skill — not as an official Google rule.

## Repository structure

```
.claude-plugin/   marketplace.json + plugin.json
skills/
  seo/            orchestrator + shared references (padroes-de-producao.md, metodologias.md)
  seo-*/          one SKILL.md per specialist
```

- Skills are written in **Portuguese (PT-BR)**. Keep the senior-consultant voice: direct,
  critical, explains *why* — avoid stacked all-caps MUSTs.
- When a skill generates or marks up output, point to `../seo/references/padroes-de-producao.md`
  instead of duplicating the production standards.
- Frontmatter must include `name`, a triggering `description`, `user-invokable: true`,
  `license: MIT`, and `metadata` (author, version, category).

## How to propose a change

1. Open an issue describing the problem or addition (a wrong tactic, an outdated AI-search
   claim, a missing skill, etc.). Cite a source for any factual correction.
2. Fork, branch, and edit the relevant `SKILL.md`. Keep edits scoped.
3. Validate: the JSON manifests parse, the frontmatter is intact, and no fabricated metric
   slipped in.
4. Open a PR. Explain *why* the change is correct, not just what changed.

## Reporting an SEO error

SEO moves fast and myths persist (keyword density, LSI, deprecated schema). If you spot a
factual error in a skill, an issue with a source link is the most valuable contribution you
can make.

— Maintained by [Anderson Melo](https://andersonmeloseo.com.br)
