# Manual — andersonmelo-seo

**O plugin de SEO de elite para Claude Code: um consultor sênior que audita e constrói.**

Por [Anderson Melo](https://andersonmeloseo.com.br) · Licença MIT · grátis · código aberto
→ Repositório: https://github.com/andersonmeloseo/andersonmelo-seo

---

## Índice

1. [O que é](#1-o-que-é)
2. [Por que é diferente](#2-por-que-é-diferente)
3. [O princípio inegociável: dados antes de diagnóstico](#3-o-princípio-inegociável)
4. [O que vem dentro](#4-o-que-vem-dentro)
5. [Requisitos](#5-requisitos)
6. [Instalação](#6-instalação)
7. [Referência de comandos](#7-referência-de-comandos)
8. [Receitas (workflows reais)](#8-receitas)
9. [A metodologia](#9-a-metodologia)
10. [Perguntas frequentes](#10-perguntas-frequentes)
11. [Solução de problemas](#11-solução-de-problemas)
12. [Sobre o autor](#12-sobre-o-autor)

---

## 1. O que é

`andersonmelo-seo` transforma o Claude Code num **consultor sênior de SEO, GEO e AEO** que faz
dois trabalhos que a maioria das ferramentas separa:

- **Diagnostica** — audita um site ou URL em 9 camadas, acha o que está errado e ordena as
  correções por `evidência → impacto → esforço → prioridade`.
- **Constrói** — arquiteta topical authority, gera páginas programáticas em escala *sem* cruzar
  a linha vermelha de conteúdo raso, escreve HTML5 semântico e marca um knowledge graph real.

É um plugin de **metodologia**, não de ferramenta. Ele não depende de APIs pagas para começar —
opera com o que o Claude já tem (coleta de página, SERP, dados que você cola) e, quando há dado
de ferramenta (Search Console, Ahrefs, etc.), usa de verdade.

Construído sobre as escolas de **Koray Tuğberk Gübür** (topical authority), **Dixon Jones**
(knowledge graph, entidades) e **Bill Slawski** (patentes do Google, recuperação de
informação), com prática de AI Search de 2026.

## 2. Por que é diferente

| | Plugins ferramenta-first | **andersonmelo-seo** |
|---|---|---|
| Aposta central | APIs, crawls, scripts | **Metodologia de estrategista sênior** |
| Postura | Reporta dados | **Audita *e* constrói** |
| Disciplina de dados | Costuma chutar | **2 modos — nunca alucina métrica** |
| Programmatic | Gera volume | **Volume só com Information Gain por página** |
| Ratings/schema | "Adicione aggregateRating" | **Integridade de ratings — marcação que você defende numa auditoria manual do Google** |

## 3. O princípio inegociável

Toda skill declara em qual dos dois modos está operando:

- **Modo Execução** — há dado ou URL acessível. Analisa de verdade, cita evidência, quantifica.
- **Modo Framework** — falta dado. Entrega o método, o que coletar e como — e **nunca apresenta
  uma estimativa como se fosse medição.**

É a linha que separa este plugin das ferramentas que inventam DA/DR, volume de busca ou "score"
sem fonte. Se você vir um número, ele veio de um dado real — ou está rotulado como heurística.

## 4. O que vem dentro

**1 orquestrador + 10 sub-skills + 5 subagents de auditoria paralela.**

O orquestrador (`/seo`) entende a intenção e roteia para a especialista certa. Você pode chamar
direto (`/seo auditoria …`) ou só descrever o problema.

### 🔍 Diagnosticar

| Skill | O que faz |
|---|---|
| **seo-auditoria** | Auditoria completa em 9 camadas → health score 0-100 + plano priorizado |
| **seo-topical** | Topical authority: mapa de tópicos entity-first, clusters, cobertura de intenção |
| **seo-on-page** | Otimização on-page de uma URL + content brief competitivo |
| **seo-geo** | GEO/AEO/LLMO: citabilidade em AI Overviews, ChatGPT, Perplexity, Gemini, Claude |
| **seo-backlinks** | Perfil de links e autoridade (free-tier: GSC/Bing/Common Crawl, ou dados pagos) |

### 🏗️ Construir

| Skill | O que faz |
|---|---|
| **seo-programmatic** | Páginas em escala, data-driven, com travas anti-thin/near-duplicate |
| **seo-schema** | Schema/JSON-LD `@graph`, knowledge graph, integridade de ratings |
| **seo-semantic-html** | HTML5 semântico + Core Web Vitals na marcação + Lighthouse 100 + a11y |
| **seo-local-rank-and-rent** | Local SEO (GBP, NAP, citações) + playbook rank-and-rent |
| **seo-hreflang** | SEO internacional: auditoria e geração de hreflang (return tags, x-default) |

### ⚙️ Subagents de auditoria

A `seo-auditoria` dispara cinco especialistas em paralelo para sites grandes:
`seo-auditor-tecnico` · `seo-auditor-conteudo` · `seo-auditor-schema` · `seo-auditor-geo` ·
`seo-auditor-arquitetura`. Cada um devolve achados no mesmo formato e a auditoria consolida no
health score.

## 5. Requisitos

- **Claude Code** instalado (CLI, app desktop, web ou extensão de IDE).
- **Nada de API paga para começar.** As skills operam com coleta de página, leitura de SERP e
  dados que você fornece.
- **Opcional, para aprofundar com dado real:** Google Search Console, Bing Webmaster Tools
  (grátis), ou Ahrefs/Semrush/Moz (pagos) — quando você cola/conecta esses dados, as skills
  saem do Modo Framework e quantificam de verdade.

## 6. Instalação

### Recomendado — plugin nativo (sem conflito)

No seu Claude Code:

```
/plugin marketplace add andersonmeloseo/andersonmelo-seo
/plugin install andersonmelo-seo@andersonmelo-seo
```

Via `/plugin`, as skills ficam isoladas por namespace e convivem com outros plugins de SEO.

### Manual (fallback, se `/plugin` não existir no seu ambiente)

```bash
git clone --depth 1 https://github.com/andersonmeloseo/andersonmelo-seo.git
bash andersonmelo-seo/install.sh
```

⚠️ O install manual copia para `~/.claude/skills/` e **sobrescreve** skills de mesmo nome de
outros plugins (ex.: o `claude-seo` também tem `seo`, `seo-geo`, `seo-schema`,
`seo-programmatic`). Se você usa outro plugin de SEO, prefira o `/plugin`.
Desinstalar: `bash andersonmelo-seo/uninstall.sh`.

## 7. Referência de comandos

Forma geral: `/seo <comando> <url|tópico>`. Você também pode só descrever o que quer — o
orquestrador roteia.

| Comando | Faz | Exemplo |
|---|---|---|
| `auditoria` | Auditoria completa + health score + plano | `/seo auditoria https://seusite.com.br` |
| `topical` | Mapa de tópicos / arquitetura de conteúdo | `/seo topical "consultoria tributária"` |
| `on-page` | Análise on-page de URL ou content brief | `/seo on-page https://seusite.com.br/artigo/` |
| `geo` | Citabilidade por IA (AI Overviews, ChatGPT…) | `/seo geo https://seusite.com.br` |
| `backlinks` | Perfil de links e autoridade | `/seo backlinks seusite.com.br` |
| `programmatic` | Plano/geração de páginas em escala | `/seo programmatic plano` |
| `schema` | Detectar/validar/gerar JSON-LD | `/seo schema https://seusite.com.br` |
| `semantic-html` | HTML5 semântico + performance | `/seo semantic-html https://seusite.com.br` |
| `local` | Local SEO + rank-and-rent | `/seo local "encanador em Campinas"` |
| `hreflang` | Auditoria/geração de hreflang | `/seo hreflang https://seusite.com.br` |

**O que esperar de uma auditoria:** modo declarado no topo → health score com composição por
dimensão → cada achado com `evidência → impacto → esforço → prioridade` → buckets
Critical/High/Medium/Low → plano de correção priorizado → "o que APIs adicionariam" → um próximo
passo concreto.

## 8. Receitas

Workflows reais que cruzam várias skills.

**🔧 Auditar e corrigir um site existente**
1. `/seo auditoria https://seusite.com.br` — pega o panorama e as prioridades.
2. Para cada Critical/High, chame a skill que cuida: `/seo schema …`, `/seo semantic-html …`.
3. `/seo geo …` por último — só depois que a base orgânica está sólida.

**🏙️ Lançar um portal programático de cidades**
1. `/seo topical "<seu serviço>"` — define a entidade central e o mapa.
2. `/seo programmatic plano` — confirma o dataset que diferencia cada página (sem isso, é
   conteúdo raso) e o padrão de URL.
3. `/seo schema …` — `@graph` de `LocalBusiness` por página.
4. `/seo hreflang …` se houver mais de um idioma/região.

**🤖 Fazer um conteúdo ser citado pela IA**
1. `/seo on-page <url>` — resposta direta no topo, entidades nomeadas, estrutura de passagem.
2. `/seo schema <url>` — `speakable`, FAQ, autor com `sameAs`.
3. `/seo geo <url>` — llms.txt, acesso de AI crawlers, citabilidade. (Lembre: GEO é camada
   *sobre* ranking orgânico — não adianta perseguir IA num site que não rankeia.)

**🔗 Avaliar autoridade sem ferramenta paga**
1. `/seo backlinks seudominio.com` — em Modo Framework ele te diz o que coletar de graça
   (GSC → Links, Bing Webmaster, Common Crawl).
2. Cole o export e ele sai pro Modo Execução e quantifica.

## 9. A metodologia

O plugin não roda só checagens — aplica a lente certa para cada problema:

- **Koray Tuğberk Gübür** → topical maps, cobertura de nicho, profundidade antes de largura.
- **Dixon Jones** → o site como grafo de entidades, `sameAs`, consolidação de marca.
- **Bill Slawski** → decisões fundamentadas em recuperação de informação, não em folclore.
- **Search Quality Rater Guidelines (set/2025)** → E-E-A-T e a linha vermelha do *scaled
  content abuse*.

Dois princípios atravessam tudo: **pense em entidades antes de páginas** (conteúdo sem entidade
definida é nó solto no grafo) e respeite a **sequência de prioridades** (técnico → arquitetura →
on-page → autoridade → GEO; esforço fora de ordem é desperdiçado).

## 10. Perguntas frequentes

**Preciso de API paga (Ahrefs, Semrush)?**
Não para começar. As skills operam com coleta de página e dados gratuitos (GSC, Bing Webmaster,
Common Crawl). Dados pagos, quando você os cola, deixam a análise mais precisa.

**Funciona em inglês?**
As skills são escritas em português, mas a metodologia é universal — o Claude executa no idioma
em que você fala com ele.

**Vai conflitar com outro plugin de SEO que eu já tenho?**
Via `/plugin` não — as skills ficam isoladas por namespace. Só o install *manual* sobrescreve
skills de mesmo nome.

**É grátis mesmo?**
Sim. Licença MIT, código aberto. Use, modifique, contribua.

**Como atualizo?**
Via `/plugin`, o Claude Code gerencia. Manual: refaça o `git clone` + `install.sh`.

**O plugin inventa números?**
Não — é o princípio central. Sem dado real, ele opera em Modo Framework e te diz o que coletar.

## 11. Solução de problemas

- **A skill não dispara** → seja específico ("audita o SEO de https://…"), ou chame direto
  (`/seo auditoria <url>`).
- **"Schema ausente" mas eu sei que tenho** → ferramentas que convertem a página para markdown
  não retornam o JSON-LD; o plugin coleta o HTML cru. Se ainda assim faltar, valide no Rich
  Results Test.
- **Instalei manual e sumiram skills de outro plugin** → o install manual sobrescreve nomes
  iguais; reinstale o outro plugin, e prefira o `/plugin` daqui pra frente.
- **Quero contribuir / achei um erro de SEO** → abra uma issue no repositório (o template pede a
  fonte). Correções com fonte são as contribuições mais valiosas.

## 12. Sobre o autor

Feito por **[Anderson Melo](https://andersonmeloseo.com.br)** — consultor de SEO especializado
em SEO programático, Local SEO, rank-and-rent e GEO, atuando no Brasil, EUA e Espanha.

Se este plugin te ajudou, deixe uma ⭐ no [repositório](https://github.com/andersonmeloseo/andersonmelo-seo)
— ajuda a alcançar mais gente. Precisa de SEO de verdade no seu projeto?
[Fale comigo](https://andersonmeloseo.com.br).

---

*andersonmelo-seo · MIT · feito no Brasil 🇧🇷*
