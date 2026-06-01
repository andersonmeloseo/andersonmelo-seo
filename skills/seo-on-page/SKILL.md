---
name: seo-on-page
description: Otimização on-page de uma página/URL e geração de content brief competitivo. Use quando o usuário pedir "otimizar essa página", "analisa essa URL", "content brief", "brief de conteúdo", "como melhorar esse artigo", "on-page dessa página", "essa página não rankeia", ou "revisar headings e título".
user-invokable: true
argument-hint: "[url|tópico]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# SEO On-Page — uma página, uma entidade, uma intenção

Você opera sobre uma unidade: uma página. O objetivo é claro — ou ela serve a intenção de busca com excelência ou não rankeia, independente do volume de texto. Esta skill tem dois usos que compartilham o mesmo ponto de partida obrigatório: **entidade e intenção primeiro**, on-page depois.

Declare qual modo está ativo antes de qualquer diagnóstico ou entrega.

- **Modo Execução** — URL acessível via WebFetch ou dados fornecidos. Analise o que existe de fato; cite evidência do HTML real.
- **Modo Framework** — sem acesso à URL ou dados. Entregue o método e o que coletar; nunca invente métricas do concorrente ou da SERP.

---

## Passo 0 (obrigatório): definir entidade e intenção

Antes de olhar um único heading ou meta tag, responda:

1. **Entidade central da página** — o que essa URL representa no grafo? Não o que o dono quer que ela seja, mas o que o Google interpreta a partir do conteúdo e dos sinais externos. Uma página sobre "instalação de ar-condicionado em São Paulo" tem como entidade o serviço, com atributos de localização e tipo de equipamento — não é um artigo de blog genérico sobre ar-condicionado.
2. **Intenção de busca real** — qual o tipo dominante (informacional, navegacional, comercial, transacional) e qual a intenção latente por trás da query? A intenção real é o que os primeiros resultados orgânicos entregam, não o que a keyword sugere literalmente. Uma página que não casa com a intenção real não rankeia por mais on-page que tenha.
3. **Qual página deveria existir aqui?** — às vezes o problema não é a otimização da página atual, é que a página atual não deveria existir nesta URL com este escopo. Se for este o caso, diga antes de qualquer outra análise.

---

## Uso A — Analisar e otimizar uma URL existente (Modo Execução)

### 1. Coleta de elementos

Acesse a URL via WebFetch e extraia:

- `<title>` — texto exato e comprimento em caracteres
- `<meta name="description">` — texto exato e comprimento
- `<link rel="canonical">` — URL e se aponta para si mesma ou para outra
- `<h1>` — texto, unicidade (deve ser único), posição no DOM
- Hierarquia de headings — H2, H3, H4 na sequência em que aparecem; anote pulos de nível
- Primeiras 80 palavras do corpo — a resposta direta está aqui? A intenção é satisfeita imediatamente?
- Cobertura de entidades — quais entidades nomeadas aparecem? Quais estão ausentes e deveriam estar?
- Marcações semânticas presentes — `<mark>`, `<dfn>`, `<dl>/<dt>/<dd>`, `<time>`, `<cite>`, `<abbr>`
- Schema JSON-LD — tipo(s) declarado(s), `@id`, propriedades presentes e ausentes
- Links internos — âncoras, destinos; se há âncora genérica ("clique aqui", "saiba mais")
- Open Graph e Twitter Card — `og:title`, `og:description`, `og:image`

### 2. Diagnóstico priorizado

Para cada problema encontrado entregue: **evidência do HTML → impacto no ranking/UX → o que corrigir**. Não é lista de checklist — é diagnóstico com causalidade.

Organize por criticidade:

**Crítico** — bloqueia ranking ou indexação (canonical errado apontando para outra URL; H1 ausente ou duplicado; intenção de busca não satisfeita nas primeiras 80 palavras; schema com tipo errado ou `@id` quebrado).

**Alto impacto** — prejudica ranking significativamente (title fora do intervalo 50-60 caracteres ou sem keyword no início; headings pulando nível H2→H4; entidades-chave ausentes do corpo; links internos com âncora genérica ou repetida).

**Melhoria incremental** — não bloqueia, mas reduz potencial (description fora do intervalo 140-155; ausência de `<mark>` em dados/estatísticas; `<dfn>` faltando na primeira menção de termo técnico; FAQ ausente quando a SERP mostra "People Also Ask").

### 3. Checklist on-page operacional

Este checklist **não é uma lista de requisitos empilhados** — cada item existe porque afeta como o Google e os LLMs entendem e rankeiam a página. Entenda o porquê de cada um.

**Title (50-60 caracteres):** o Google exibe ~600px; fora dessa janela, trunca ou reescreve. A keyword principal deve aparecer antes da vírgula ou do pipe — é o sinal mais pesado de relevância na tag.

**Description (140-155 caracteres):** não é fator de ranking direto, mas taxa de clique (CTR) é. Uma description que reproduz a resposta da intenção e tem call-to-action claro eleva CTR e, indiretamente, sinaliza relevância por comportamento.

**Um único H1 com keyword:** múltiplos H1 diluem o sinal de tópico principal. H1 sem keyword é oportunidade desperdiçada. O H1 não precisa ser idêntico ao title — pode ser uma variação semântica.

**Hierarquia sem pulos:** H2→H3 é navegação temática; pular para H4 quebra o grafo semântico da página. Cada H2 deve representar um conceito ou pergunta autônoma (≤68 caracteres).

**Resposta direta nos primeiros 60-80 termos:** a SERP exibe o início do conteúdo nos snippets de texto; um LLM extrai o primeiro bloco semântico como resposta candidata. Se a página começa com história ou contexto genérico, perde snippet e citação.

**Entidades nomeadas no corpo:** LLMs e o Knowledge Graph do Google constroem contexto a partir de entidades, não de keywords. Citar o bairro, o serviço específico, a norma técnica ou o nome do fabricante é marcar posição no grafo, não só otimizar para uma query.

**`<mark>` em dados, `<dfn>` na primeira menção de termos:** dados em `<mark>` são extraídos com prioridade por parsers de LLM. `<dfn>` sinaliza que a página define um conceito — aumenta a chance de ser fonte de definição em AI Overviews.

**FAQ com perguntas reais:** perguntas fabricadas para encaixar keywords não geram PAA. Perguntas reais (extraídas do PAA atual, do autocomplete, de fóruns) geram snippet e citação. O schema `FAQPage` só tem valor quando as perguntas correspondem ao que o Google já mostra.

**Schema do tipo correto:** um serviço de reforma marcado como `Article` não aciona o rich result de serviço. O tipo deve refletir a entidade da página — `Service`, `LocalBusiness`, `HowTo`, `FAQPage`, `Article`, conforme o caso. `@id` deve ser a URL canônica da página.

---

## Uso B — Gerar um content brief para página nova

O content brief é o documento que define o que a página precisa ser antes de qualquer palavra ser escrita. Não é uma lista de tópicos — é a arquitetura da entidade.

### Estrutura do brief

**1. Entidade e intenção**
- Entidade central e seus atributos principais
- Intenção dominante da query-alvo (informacional / comercial / transacional)
- Intenção latente: o que o usuário realmente quer além do que a keyword diz

**2. SERP-alvo (Modo Execução) ou hipótese de intenção (Modo Framework)**
- Em Modo Execução: quais tipos de resultado aparecem no top 5 para a query principal? São artigos, páginas de serviço, comparativos, calculadoras? Isso define o formato da página, não a preferência do produtor.
- Em Modo Framework: descreva o formato mais provável dado o tipo de intenção e sinalize que precisa de verificação na SERP real antes de produzir.

**3. Estrutura H2/H3**
Para cada seção, entregue:
- O heading exato (≤68 caracteres, em forma de pergunta ou conceito atômico)
- O que a seção responde (1-2 frases)
- O elemento de IG que diferencia esta seção do que já existe na SERP

**4. Information Gain por seção**
Confirme os mínimos por tipo de página conforme `../seo/references/padroes-de-producao.md`:
- Cluster: 3 elementos de IG
- Hub: 4 elementos
- Pillar: 5 elementos
Nomeie o tipo de IG de cada seção (dado primário, framework, tabela comparativa, estudo de caso, contraponto, glossário próprio). Sem IG real identificado, o brief fica incompleto — sinalize ao usuário o que precisa fornecer.

**5. Links internos sugeridos**
Liste 3-5 páginas do site que devem linkar para esta ou receber link desta, com âncora sugerida para cada uma. A âncora deve ser descritiva e variada — nunca "clique aqui" ou a mesma frase repetida.

**6. Schema recomendado**
Tipo primário, propriedades obrigatórias e a relação com o `@graph` do site (como esta página se conecta à entidade principal do domínio via `@id`).

**7. Contagem-alvo de palavras**
Conforme o tipo de página definido em `../seo/references/padroes-de-producao.md`:
- Página de serviço: 1.200 palavras
- Cluster: 1.500 palavras
- Hub: 2.000 palavras
- Pillar: 2.500 palavras
Não é meta — é mínimo para cobrir a intenção com profundidade adequada.

---

## Modo Framework — quando não há acesso à URL

Quando a URL não está acessível e não há dados fornecidos, o diagnóstico de "sua página não rankeia porque..." sem evidência é chute, não análise. O que você entrega neste modo:

1. Lista dos elementos a coletar manualmente (title, description, canonical, H1, hierarquia, primeiras 80 palavras, entidades, schema, links internos, OG)
2. Para cada elemento: o que verificar, o que constitui problema e por quê esse problema afeta ranking
3. Instrução de como coletar: inspecionar o HTML-fonte (não o renderizado pelo browser), não confiar em plugins que mostram dados cacheados
4. O que a ausência de dados implica na confiança do diagnóstico — diga claramente que sem dados reais, a priorização é hipotética

---

## Entrega final

**Para Uso A:** diagnóstico priorizado por criticidade (Crítico → Alto → Incremental), com evidência do HTML para cada item, e o que corrigir em cada caso. Encerre com o próximo passo concreto — a correção de maior impacto primeiro.

**Para Uso B:** o brief completo seguindo a estrutura da seção anterior. Encerre com o que o produtor de conteúdo precisa fornecer (dado primário, experiência de primeira mão, estatísticas) para que o IG mínimo seja atingido.

Nunca termine com resumo motivacional ou lista de "pontos positivos". A página ou passa no diagnóstico ou há trabalho a fazer — aponte o trabalho.
