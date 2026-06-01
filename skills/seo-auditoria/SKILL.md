---
name: seo-auditoria
description: Auditoria SEO completa de um site ou URL — diagnóstico técnico, de conteúdo, autoridade e performance com score ponderado e plano de correção priorizado. Use quando o usuário pedir "auditar meu site", "fazer um SEO check", "analisa esse site", "por que meu site não rankeia", "saúde de SEO", "auditoria técnica", "revisar meu site inteiro", "checar indexação", "encontrar problemas de SEO", "diagnóstico completo" ou qualquer variante de verificação geral da saúde de um domínio.
user-invokable: true
argument-hint: "[url]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# seo-auditoria — diagnóstico que antecede qualquer otimização

## Declare o modo antes de qualquer análise

Toda auditoria começa aqui, antes de emitir qualquer julgamento:

- **Modo Execução** — a URL é alcançável, você coletou HTML, robots.txt, sitemap e dados reais. Cada achado cita evidência concreta do que foi encontrado.
- **Modo Framework** — a URL está inacessível, foi bloqueada ou nenhum dado foi fornecido. Você entrega o método: o que coletar, como coletar e o que cada achado significaria. Não inventa conteúdo, não estima o que não viu, não atribui problemas sem base.

Se a URL falhar (timeout, 403, DNS), diga isso imediatamente e ofereça o que é possível: análise de cache público, dados fornecidos pelo usuário, ou Modo Framework para o segmento relevante. Nunca chute o conteúdo de uma página que você não conseguiu ler.

---

## Etapa 1 — Coleta de dados reais

A qualidade da auditoria é proporcional à qualidade dos dados. Colete na seguinte ordem:

**1.1 Robots e rastreabilidade**
Busque `[domínio]/robots.txt` via WebFetch. Confirme se Googlebot (e crawlers de IA: GPTBot, GoogleExtended, PerplexityBot, ClaudeBot, Bingbot) estão permitidos nos caminhos relevantes. Um `Disallow: /` acidental apaga todo o esforço posterior — verifique primeiro.

**1.2 Sitemap**
Localize o sitemap via `robots.txt` (diretiva Sitemap:) ou tentativa em `/sitemap.xml` e `/sitemap_index.xml`. Anote: quantas URLs declaradas, data de modificação mais recente, presença de imagens/vídeos/news no sitemap, URLs que aparecem no sitemap mas retornam 404 ou redirect.

**1.3 Home e páginas-amostra**
Faça WebFetch da home. Depois, selecione uma amostra representativa: a página de categoria/hub mais importante, uma página de conteúdo/serviço de segundo nível, e uma página de long-tail (se o site tiver). Três a cinco páginas já revelam padrões estruturais. Em sites grandes (50+ páginas indexáveis), amostrar é obrigatório — diga explicitamente quais URLs foram analisadas e quais ficaram fora.

**1.4 Detecção de renderização**
Compare o HTML retornado pelo WebFetch (UA padrão) com o que um usuário vê. Se o corpo principal — título H1, conteúdo textual, links de navegação — estiver ausente no HTML inicial e depender de JavaScript para existir, o site provavelmente tem problema de renderização para o Googlebot. Sinais de SPA ou renderização cliente-side exigem verificação de prerender/SSR: cheque se há `<noscript>` com conteúdo real, metatags de prerender, ou indícios de framework (atributos `data-reactroot`, `__next`, `ng-version`, `data-server-rendered`). Sem acesso a logs ou GSC, classifique como risco provável, não confirmado.

**1.5 Tipo de negócio**
A partir da home, identifique o modelo: SaaS/produto digital, negócio local de serviço (uma ou múltiplas cidades), e-commerce, publisher/blog, agência/consultoria, portal programático. O tipo determina quais dimensões têm peso maior na auditoria e quais riscos são mais críticos (ex.: local exige NAP e GBP; publisher exige E-E-A-T de autoria; programático exige unicidade por página).

---

## Etapa 2 — As 9 camadas de auditoria

Varra cada camada em sequência. A ordem não é arbitrária: problemas das camadas iniciais invalidam o esforço das posteriores. Se a camada 1 bloqueia rastreamento, as camadas 3 a 9 são ruído.

**Delegação paralela (quando há subagents):** em ambiente com subagents disponíveis, dispare os cinco auditores especialistas em paralelo — é mais rápido e mais profundo em sites grandes:
- `seo-auditor-tecnico` → camadas 1, 2, 8 (rastreabilidade, renderização, performance, segurança)
- `seo-auditor-arquitetura` → camadas 3, 4 (estrutura, cobertura de intenção, canibalização)
- `seo-auditor-conteudo` → camadas 5 (conteúdo) e 6 (E-E-A-T)
- `seo-auditor-schema` → schema/JSON-LD da camada 5 (coleta o HTML cru, não confia no WebFetch)
- `seo-auditor-geo` → camada 9 (AI Search)

Cada auditor devolve achados no formato evidência→impacto→esforço→prioridade + uma nota 0-100 da sua dimensão; você consolida no relatório e no health score. Sem subagents, varra as camadas inline na sequência abaixo.

### Camada 1 — Rastreabilidade e indexação
O que investigar: robots.txt bloqueando caminhos importantes; sitemap desatualizado ou ausente; URLs com `noindex` onde não deveria; parâmetros de URL gerando duplicatas rastreáveis (filtros, ordenação, paginação sem canonical); páginas órfãs sem link interno; explosão combinatória de URLs (faceted navigation, calendários, tags sem limite). Em sites com 30+ páginas de localidade, acione o quality gate de escala (ver abaixo).

### Camada 2 — Renderização
O que investigar: conteúdo principal dependente de JS para existir no DOM; ausência de SSR/prerender; Googlebot não vendo o que o usuário vê; iframes contendo conteúdo relevante sem alternativa em texto. Um site que parece ótimo no browser mas entrega HTML vazio ao crawler é invisível para o Google.

### Camada 3 — Arquitetura de informação
O que investigar: profundidade de cliques (páginas importantes a mais de 3 cliques da home precisam de justificativa); estrutura de silos ou clusters (as páginas sobre o mesmo tópico se conectam entre si?); canibalização de intenção (duas URLs competindo pela mesma query com intenção idêntica); lógica de URLs (legível, hierárquica, sem parâmetros desnecessários); breadcrumb presente e coerente com a hierarquia real. Avalie o site como um grafo, não como uma lista de páginas.

### Camada 4 — Cobertura de intenção e tópicos
O que investigar: há topical map explícito? A estrutura de conteúdo cobre as intenções da jornada (informacional, comercial, transacional) para o nicho? Quais tópicos satelitais faltam? Quais existem mas estão subdesenvolvidos? Gaps de cobertura significam oportunidade para concorrentes. Sem topical map declarado, classifique isso como risco estrutural — o site pode ter autoridade tópica acidental, mas não construída.

### Camada 5 — On-page
O que investigar por página amostrada: title (50-60 caracteres, keyword principal, diferenciador); meta description (140-155, call-to-action implícito); H1 único e alinhado com a intenção da query; hierarquia de headings sem pulos; primeiros 80 termos respondem a query diretamente; entidades nomeadas no corpo; schema presente e correto; links internos com âncoras variadas e semânticas; ausência de clichês e conteúdo de enchimento. Para cada problema encontrado, anote a URL e o dado exato — não generalize.

> **Nota sobre schema via WebFetch:** WebFetch e conversões para markdown frequentemente NÃO retornam os blocos `application/ld+json`. Antes de concluir "schema ausente", confirme via fetch do HTML cru (curl) ou pelo Rich Results Test — ausência no WebFetch não é evidência de ausência no site.

### Camada 6 — Qualidade (E-E-A-T)
O que investigar: autoria identificável com nome real, bio, links para perfis verificáveis? Há experiência de primeira mão demonstrável (casos reais, dados próprios, fotos)? Em YMYL (saúde, finanças, direito, home services), a régua é máxima — conteúdo sem autoria identificável e sem dado primário é passivo de penalidade. Para sites locais, há sinais de negócio real (endereço, telefone, fotos, depoimentos com nome)? Consistência de NAP entre site e GBP?

### Camada 7 — Autoridade
O que investigar com dados disponíveis: perfil de links (se Ahrefs/Moz/Semrush fornecido — analise toxicidade, distribuição de anchor text, velocidade de crescimento); entidade no Knowledge Graph do Google (busca pelo nome da marca retorna painel de entidade?); menções de marca sem link; `sameAs` no schema apontando para perfis reais e ativos. Sem dados de backlinks fornecidos, declare a lacuna e o que ela impede de concluir — não estime métricas de DA/DR sem fonte.

### Camada 8 — Performance e Core Web Vitals
O que investigar: se dados de campo (GSC, CrUX, PageSpeed Insights com dados reais) foram fornecidos, use-os — dados de campo (CrUX) são o input de ranking; dados de lab (Lighthouse) são o fallback válido para páginas sem field data suficiente — declare qual dos dois está usando. Se não foram fornecidos dados de campo, a análise de performance é estimada a partir do HTML coletado: presença de CSS crítico inline, imagens com dimensões declaradas, JS bloqueante no `<head>`, fontes via CDN externo, scripts de terceiros no carregamento inicial, preload do hero image. Declare explicitamente: "score de performance estimado a partir de sinais de HTML/lab — sem field data (CrUX/GSC) não é possível confirmar LCP, CLS ou INP reais."

Alvos de CWV: LCP — limiar 'Good' de campo (CrUX) = 2,5s; alvo de produção/lab = 2,0s · CLS < 0,1 · INP < 200ms. Os parâmetros técnicos de produção estão em `../seo/references/padroes-de-producao.md` §5.

### Camada 9 — GEO/AEO (AI Search)
O que investigar: crawlers de IA estão permitidos no robots.txt? Há `llms.txt` no domínio? O conteúdo usa estrutura que favorece citação (resumo executivo, `speakable`, parágrafos autossuficientes, entidades nomeadas, fontes com `<cite>`)? O site aparece em respostas de ChatGPT/Perplexity/AI Overviews para as queries principais? Esta camada é uma otimização sobre uma base orgânica sólida — se as camadas 1-5 têm problemas críticos, GEO é prematuro.

---

## Classificação de achados

Cada problema identificado recebe quatro atributos antes de entrar no relatório:

- **Evidência:** o dado concreto encontrado (URL, trecho de HTML, valor medido).
- **Impacto:** o que este problema custa em termos de visibilidade, indexação ou conversão.
- **Esforço:** estimativa de complexidade da correção (horas de dev, revisão editorial, configuração).
- **Prioridade:** um dos quatro buckets abaixo.

**Buckets de prioridade:**

| Bucket | Critério |
|--------|----------|
| **Critical** | Bloqueia indexação, causa penalidade manual ou derruba rankings globalmente. Correção imediata — nada mais avança sem resolver isso. |
| **High** | Impacta diretamente o ranking de páginas importantes. Resolve em até 2 semanas. |
| **Medium** | Otimização que melhora performance, CTR ou E-E-A-T. Resolve no próximo ciclo. |
| **Low** | Backlog técnico ou editorial que agrega margem. Resolve quando houver capacidade. |

Não infle a lista de Critical para parecer mais impactante. Um site com 8 Critical tem um problema grave. Se a lista de Critical chegar a dezenas de itens, revise a classificação — provavelmente há itens Medium/Low promovidos demais.

---

## Health Score 0-100

O score é uma síntese ponderada, não uma média aritmética. Use os pesos abaixo:

| Dimensão | Peso |
|----------|------|
| Técnico (rastreabilidade, renderização, performance) | 30% |
| Conteúdo e E-E-A-T | 25% |
| On-page (title, headings, schema, intenção) | 20% |
| Arquitetura de informação | 10% |
| Autoridade (links, entidade) | 10% |
| AI Search (GEO/AEO) | 5% |

Calcule cada dimensão de 0 a 100 com base nos achados, aplique o peso e some. O score final é orientativo — seu valor real está no detalhamento por dimensão, não no número isolado.

**Transparência obrigatória:** se dados de campo (GSC, CrUX) estiverem ausentes, declare no score: "O score de performance é estimado a partir de sinais de HTML/lab; com dados de campo (CrUX/GSC) pode variar de forma relevante — trate a dimensão de performance como estimada até confirmar com field data." Nunca apresente um score de 94 como medição precisa quando parte dele é estimativa.

---

## Quality gate de escala programática

Quando o site tiver 30 ou mais páginas de localidade (cidade × serviço, bairro × categoria, etc.), emita o seguinte alerta antes de continuar:

> **Alerta de escala:** este site tem [N] páginas de localidade. A partir de ~30 páginas *(heurística operacional desta skill — não é threshold oficial do Google; serve para disparar escrutínio de unicidade)*, o Google tende a escrutinar a unicidade de conteúdo por página. Páginas que apenas trocam o nome da cidade sem oferecer dado local diferenciado configuram *scaled content abuse* segundo as Search Quality Rater Guidelines — risco de ação manual.

Se houver 50 ou mais páginas deste tipo *(mesmo critério — heurística operacional, não threshold oficial)*, exija justificativa de unicidade antes de prosseguir: qual dado específico diferencia cada página? Faixas de preço locais, tempo médio de obra, exemplos de projetos na cidade, parceiros locais, regulamentações municipais? Se não houver resposta concreta, classifique o risco como Critical na dimensão de conteúdo/E-E-A-T.

---

## Estrutura do relatório de saída

O relatório segue esta sequência — não altere a ordem, ela replica a pirâmide invertida:

**1. Resumo executivo**
Em até 150 palavras: Health Score com composição percentual por dimensão; tipo de negócio identificado; top 5 achados críticos com uma linha cada; top 5 quick wins (alto impacto, baixo esforço). Esta seção é o que o cliente lê primeiro e às vezes é tudo que lê.

**2. Seções por dimensão**
Uma seção para cada camada das 9 auditadas. Cada seção: o que foi encontrado (com evidência), o que significa para o ranking, e os achados classificados por bucket. Seção sem achados = "Nenhum problema identificado na amostra analisada" — não pule silenciosamente.

**3. Plano de correção priorizado**
Lista ordenada de ações: Critical primeiro, depois High, Medium, Low. Para cada ação: o que fazer, por quê importa, qual página ou sistema afeta, e se há dependência com outra ação (ex.: "corrigir renderização antes de otimizar on-page"). Correções de HTML, schema ou conteúdo geradas seguem `../seo/references/padroes-de-producao.md`.

**4. O que APIs e credenciais adicionariam**
Declare explicitamente o que não foi possível auditar sem acesso a: Google Search Console (cobertura de indexação real, impressões por query, erros de rastreamento), CrUX/PageSpeed com dados de campo (LCP/CLS/INP reais), ferramentas de backlink (Ahrefs, Semrush, Moz) para perfil de links — o método de coleta, inclusive free-tier (GSC/Bing/Common Crawl), está na skill `seo-backlinks`, Google Business Profile para local SEO. Cada item ausente é uma zona cega — nomeie ela.

**5. Próximo passo concreto**
Uma ação única e específica que o usuário deve fazer amanhã. Não uma lista de "próximos passos". Uma ação, com instrução suficiente para executar. O relatório termina aqui.

---

## Tratamento de erros e limitações

**URL inacessível:** declare imediatamente. Não chute o conteúdo. Ofereça alternativas: cache do Google (`cache:[url]`), WebFetch com UA diferente, ou solicite ao usuário que cole o HTML ou forneça acesso.

**Robots bloqueando o crawl:** documente como Critical se bloquear Googlebot. Se bloquear só crawlers de IA (GPTBot, ClaudeBot, etc.), documente como Medium na camada 9 — bloquear AI crawlers não impacta ranking orgânico; o impacto é exclusivo de GEO/AEO. Classifique como High apenas se IA Search for canal prioritário declarado pelo cliente.

**Rate limit:** reduza a amostra. Documente quais URLs ficaram de fora e o que isso limita na análise.

**Site grande (100+ páginas):** amostre sistematicamente — home, hub principal, 2-3 páginas de segundo nível, 1-2 páginas de long-tail. Declare o tamanho do site e a lógica de seleção da amostra. Padrões estruturais se revelam em 5-8 páginas; achados pontuais exigem crawl completo com ferramenta dedicada.

**Dados inconsistentes:** se o sitemap declara 500 URLs mas o site parece ter 50, investigue antes de concluir — pode ser sitemap desatualizado, pode ser geração dinâmica, pode ser index bloat. Declare a inconsistência como achado antes de interpretá-la.
