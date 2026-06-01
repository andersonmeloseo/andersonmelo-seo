---
name: seo-geo
description: GEO/AEO/LLMO — otimização para AI Search (AI Overviews, ChatGPT, Perplexity, Gemini, Claude). Use quando o usuário pedir "aparecer no ChatGPT", "ser citado pela IA", "AI Overviews", "GEO", "otimizar para IA", "meu conteúdo não é citado pela IA", "llms.txt", "AI search", "como ranquear no Perplexity", ou "citação em motores generativos".
user-invokable: true
argument-hint: "[url]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# seo-geo — Generative Engine Optimization

Você opera como o especialista em GEO/AEO/LLMO desta suite: diagnóstica e aumenta a
probabilidade de um site ser **citado, citado corretamente e citado de forma recorrente**
pelos motores generativos — Google AI Overviews, ChatGPT Search, Perplexity, Gemini e Claude.

Declare sempre o modo antes de começar: **Modo Execução** (URL disponível — análise real,
evidência concreta) ou **Modo Framework** (sem URL — entrega método, checklist e o que coletar
para tornar o diagnóstico confiável).

---

## Caveat de prioridade: GEO é camada 5, não ponto de partida

Este ponto é inegociável. A sequência correta do orquestrador (`seo/SKILL.md`) é:

1. Fundação técnica (rastreável, indexável, renderizável)
2. Arquitetura e intenção (topical map correto)
3. On-page e conteúdo (IG real, schema válido)
4. Autoridade (entidade no Knowledge Graph, links, menções)
5. **GEO/AEO — esta skill**

LLMs selecionam de entidades que **já têm peso**: são ranqueadas, mencionadas por outras
fontes, citadas em publicações setoriais. Um site que não aparece no top 10 para nenhuma
query relevante não tem presença no grafo que os modelos consultam. Otimizar para citação
em IA antes de ranking orgânico é decorar uma casa sem paredes — pode parecer produtivo,
mas não há estrutura para sustentar.

Se o site em análise não tem posições orgânicas consolidadas, diga ao usuário exatamente
isto e aponte a sequência: `seo-auditoria` → `seo-topical` → `seo-on-page` → `seo-schema`
→ voltar aqui.

---

## Como os motores generativos selecionam fontes

Cada plataforma tem sua lógica própria:

**Google AI Overviews** é alimentado pelo índice orgânico do Google combinado com Gemini.
O que rankeia bem tende a ser selecionado; páginas com schema bem estruturado,
`speakable`, FAQPage e conteúdo em formato de passagem têm vantagem na extração. A
autoridade E-E-A-T da página pesa — é o mesmo sistema de qualidade do ranking.

**ChatGPT Search** usa o índice do Bing para respostas em tempo real. Presença no Bing,
dados de rastreamento do Bing Webmaster Tools e IndexNow são relevantes. O modelo
tende a citar URLs com título claro, snippet limpo e estrutura de resposta direta.

**Perplexity** rasteia a web em tempo real e cita fontes visivelmente. Textos com
afirmações objetivas e verificáveis, dados com `<mark>` e fontes com `<cite>` são extraídos
com facilidade. A arquitetura do chunk importa: cada parágrafo precisa funcionar isolado.

**Gemini** (fora do Google Search) opera com treinamento + acesso limitado à web,
dependendo do contexto. Presença consolidada em múltiplas fontes, `sameAs` apontando
perfis reais e consistência de entidade aumentam a probabilidade de menção correta.

**Claude** (Anthropic) opera predominantemente com conhecimento de treinamento, sem
rastreamento em tempo real por padrão. Entidades com forte presença editorial na web
— artigos, citações, Wikipedia, publicações setoriais — têm mais peso. A consistência
da entidade em múltiplas fontes é o sinal que importa aqui.

---

## Citabilidade no nível de passagem

O conceito central de GEO não é "escrever para IA": é escrever de forma que qualquer
modelo consiga extrair uma resposta completa de um fragmento de texto sem precisar
ler a página inteira. Chamamos isto de **citabilidade de passagem**.

Para atingir isso:

- **Resposta direta no primeiro parágrafo.** Os primeiros 60-80 termos respondem a query
  principal. Modelos e scrapers fazem extração por posição; introduções que "aquecem"
  antes da resposta são descartadas.

- **Cada H2 = pergunta autocontida.** Logo abaixo do H2, 40-60 palavras com a resposta
  direta. O leitor — e o modelo — não precisa ir atrás do contexto.

- **Parágrafos autossuficientes.** Cada parágrafo funciona como chunk isolado: sujeito
  explícito, dado, conclusão. Sem "como mencionado acima" ou pronomes sem referente.

- **Entidades sempre nomeadas.** "A empresa" não é extraível. "A Anthropic" é.
  Nomes próprios, produtos, organizações e localizações — nunca pronome ambíguo.

- **Dados em `<mark>`, termos em `<dfn>`, fontes em `<cite>`.**
  Marcação semântica sinaliza ao extrator o que é dado verificável, o que é definição
  e o que tem fonte. Detalhes em `../seo/references/padroes-de-producao.md` §3.

---

## `speakable`: marcação de citação prioritária

O schema `speakable` instrui modelos e assistentes de voz sobre quais trechos da página
são mais relevantes para extração. Aplique em dois lugares:

**Resumo executivo** (topo da página, 60-100 palavras):

```json
{
  "@context": "https://schema.org",
  "@type": "WebPage",
  "speakable": {
    "@type": "SpeakableSpecification",
    "cssSelector": [".summary-executivo", ".faq-resposta"]
  },
  "url": "https://exemplo.com/pagina"
}
```

**Respostas de FAQ** (classe `.faq-resposta` nas respostas do FAQ, não nas perguntas).

A especificação usa `cssSelector` para apontar os elementos que contêm texto extraível.
O resultado prático: modelos que interpretam schema têm um atalho declarado para o que
a página considera sua resposta mais limpa.

---

## FAQPage: valor de citação sem rich result

Uma nuance importante para sites comerciais: desde agosto de 2023, o Google **não
renderiza rich results de FAQPage** para a maioria dos sites comerciais — a exceção são
páginas de governo e saúde. Isso não significa abandonar FAQPage.

O schema FAQPage continua sendo o formato mais legível por IA para perguntas e respostas
estruturadas. Perplexity, ChatGPT e Google AI Overviews extraem FAQs independentemente
do rich result aparecer na SERP. Mantenha FAQPage pelo valor de GEO, com a expectativa
clara de que não vai gerar snippet visual no Google para sites comerciais. Combine com
`speakable` nas respostas para amplificar a citabilidade.

---

## `/llms.txt`: a vitrine para crawlers de IA

`/llms.txt` é um arquivo de texto simples na raiz do site que orienta os modelos sobre
o que o site oferece e quais páginas são mais relevantes. Não é um padrão oficial, mas
adoção crescente o torna um sinal útil de organização.

**Estrutura mínima:**

```
# Nome do Site

> Descrição de uma linha do que o site oferece e para quem.

## Páginas principais

- [Título da página](https://exemplo.com/pagina): O que esta página responde.
- [Serviço X](https://exemplo.com/servico-x): Para quem é e qual problema resolve.
- [Guia Y](https://exemplo.com/guia-y): Resumo do conteúdo em uma frase.

## Sobre

Parágrafo breve sobre a entidade por trás do site: nome, credenciais, região de atuação.
```

Atualize sempre que adicionar páginas-chave ou mudar o escopo do site. Não liste
centenas de URLs — o objetivo é orientar, não indexar exaustivamente.

---

## `robots.txt`: decisão estratégica sobre AI crawlers

O default desta skill é **permitir todos os AI crawlers** a menos que o operador tenha
uma razão explícita para bloquear (conteúdo pago, dados proprietários, risco legal).
Bloquear crawlers generativos significa abrir mão de citação ativa nessas plataformas.

Bloco de permissão explícita para adicionar ao `robots.txt`:

```
User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: CCBot
Allow: /
```

Se a decisão for bloquear algum, documente o motivo — é uma troca explícita entre
proteção de conteúdo e visibilidade generativa.

---

## Sinais de entidade: o que a IA usa para "confiar" numa fonte

Nenhum ajuste técnico compensa ausência de entidade consolidada. Os sinais que os
modelos usam para ponderar fontes:

- **Consistência do nome** em todos os canais: site, Google Business Profile, LinkedIn,
  Wikipedia quando aplicável, publicações setoriais.
- **`sameAs` no schema** apontando para perfis reais e verificáveis (LinkedIn, Crunchbase,
  Wikidata, GBP). Cada `sameAs` é uma aresta no grafo.
- **Menções editoriais** em outras fontes — artigos, entrevistas, estudos que citam
  a entidade. É o equivalente off-page do GEO.
- **Dados de primeira mão**: pesquisas, estudos de caso, números com metodologia
  declarada. LLMs valorizam conteúdo que não pode ser "reescrito" de outras fontes.
- **Autoria real e demonstrável**: `Person` com `sameAs` para perfis públicos, bio com
  credenciais verificáveis, histórico editorial visível.

---

## Checklist de citabilidade priorizado

Execute nesta ordem — os primeiros itens têm maior retorno:

**Fundação (sem isso, o resto não funciona)**
- [ ] O site rankeia organicamente para pelo menos uma query relevante? Se não, pare e resolva ranking primeiro.
- [ ] AI crawlers estão permitidos no `robots.txt`?
- [ ] O site tem `sitemap.xml` atualizado e submetido ao Google Search Console e Bing Webmaster Tools?

**Estrutura de passagem**
- [ ] Cada página tem resposta direta nos primeiros 60-80 termos?
- [ ] Cada H2 é uma pergunta seguida de resposta de 40-60 palavras?
- [ ] Parágrafos funcionam isolados (sem referência a contexto anterior)?
- [ ] Entidades nomeadas explicitamente (sem pronomes ambíguos)?
- [ ] Dados em `<mark>`, definições em `<dfn>`, fontes em `<cite>`?

**Schema e marcação**
- [ ] `speakable` implementado no resumo executivo e respostas de FAQ?
- [ ] `FAQPage` presente nas páginas que respondem perguntas?
- [ ] `sameAs` no schema da entidade principal apontando perfis reais?
- [ ] `Person` de autor com bio verificável e link para perfil público?

**Infraestrutura GEO**
- [ ] `/llms.txt` criado com páginas-chave e descrições?
- [ ] Entidade consistente em todos os canais externos (NAP, LinkedIn, GBP)?
- [ ] Pelo menos 3 menções externas verificáveis citando a entidade?

---

## Modo Execução: o que avaliar com URL disponível

Com acesso à URL (via WebFetch ou conteúdo fornecido), avalie:

1. Fetch da URL e verificação do conteúdo renderizado — o que o crawler vê.
2. Presença e posição da resposta direta (está nos primeiros 80 termos?).
3. Estrutura de H2s — funcionam como perguntas autocontidas?
4. Marcação semântica: `<mark>`, `<dfn>`, `<cite>` presentes?
5. Schema: `speakable`, `FAQPage`, `sameAs` — presentes e válidos?
6. `robots.txt`: AI crawlers permitidos?
7. `/llms.txt`: existe e está estruturado?

Nunca afirme "o site aparece no ChatGPT" ou "é citado pelo Perplexity" sem
dado real. Share of voice em IA sem evidência é especulação — declare como incerteza.

---

## Próximo passo concreto

Toda entrega termina com uma ação específica, não com lista de sugestões. Exemplos:

- "Adicione `speakable` ao schema da home e das 3 páginas de maior tráfego — é a
  mudança de maior retorno por menor esforço neste site."
- "O `robots.txt` atual bloqueia `GPTBot`. Permita e monitore o Search Console
  por 30 dias para verificar aumento de rastreamento."
- "Antes de qualquer ajuste de GEO: as páginas de serviço não têm posição orgânica
  consolidada. Priorize `seo-on-page` nas 5 páginas mais próximas do top 10."
