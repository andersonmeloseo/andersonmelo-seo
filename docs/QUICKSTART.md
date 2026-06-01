# Como testar o andersonmelo-seo

Três jeitos, do mais rápido ao mais completo.

## 1. Instalação nativa (recomendado — sem conflito)

No seu Claude Code:

```
/plugin marketplace add andersonmeloseo/andersonmelo-seo
/plugin install andersonmelo-seo@andersonmelo-seo
```

Via `/plugin` as skills ficam isoladas por namespace — convivem com outros plugins de SEO.

Depois, teste com qualquer um destes (copia e cola):

```
/seo auditoria https://seusite.com.br
/seo topical "seu nicho aqui"
/seo on-page https://seusite.com.br/uma-pagina/
/seo schema https://seusite.com.br
/seo geo https://seusite.com.br
/seo backlinks seusite.com.br
/seo hreflang https://seusite.com.br
/seo local "encanador em Campinas"
/seo programmatic plano
```

Ou em linguagem natural — o orquestrador roteia sozinho:

> "por que essa página não rankeia? https://…"
> "monta a arquitetura de conteúdo pra um portal de cidades de [serviço]"
> "como faço esse site aparecer no ChatGPT?"
> "analisa o perfil de backlinks do meu concorrente"

## 2. Instalação manual (fallback, se `/plugin` não existir no seu ambiente)

```bash
git clone --depth 1 https://github.com/andersonmeloseo/andersonmelo-seo.git
bash andersonmelo-seo/install.sh
```

⚠️ **Atenção:** o install manual copia para `~/.claude/skills/` e **sobrescreve** skills de
mesmo nome de outros plugins (ex.: o `claude-seo` também tem `seo`, `seo-geo`, `seo-schema`,
`seo-programmatic`). Se você usa outro plugin de SEO, prefira o `/plugin` (item 1).
Desinstalar: `bash andersonmelo-seo/uninstall.sh`.

## 3. Sem instalar nada — peça ao Claude

Aponte o Claude para um `SKILL.md` deste repo e peça para ele seguir a skill na sua tarefa.
Bom para inspecionar a metodologia antes de instalar.

## O que esperar

- Toda saída começa declarando o **modo**: *Execução* (com dados/URL — analisa de verdade) ou
  *Framework* (sem dados — entrega o método, sem inventar número).
- **Auditoria:** health score ponderado + achados `evidência → impacto → esforço → prioridade`
  + plano priorizado + "o que APIs adicionariam".
- Em site grande, a `seo-auditoria` dispara os **5 subagents de auditoria** em paralelo.

## Validar o repo localmente (para contribuir)

```bash
python3 scripts/validate.py
```
