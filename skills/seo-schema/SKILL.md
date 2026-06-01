---
name: seo-schema
description: Schema/JSON-LD, dados estruturados, knowledge graph e rich results de elite. Use quando o usuário pedir "adicionar schema", "dados estruturados", "JSON-LD", "rich results", "markup do Google", "schema de LocalBusiness", "@graph", "structured data", "aggregateRating", "schema de FAQ/produto/artigo", "validar schema", "corrigir JSON-LD", "qual tipo de schema usar", ou "por que não aparece rich snippet".
user-invokable: true
argument-hint: "[url|tipo de página]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# seo-schema — O site é um grafo; o schema é o mapa

Schema.org não é enfeite. É a linguagem que o Google usa para extrair entidades, consolidar
o conhecimento sobre o seu site e decidir se merece rich results. Cada nó JSON-LD que você
publica é uma afirmação sobre quem você é, o que você faz e como as suas entidades se
relacionam. Afirmação errada ou fabricada tem consequência. Afirmação precisa e interligada
acumula autoridade de entidade ao longo do tempo.

Declare qual modo está em uso antes de começar:

- **Modo Execução** — URL fornecida ou schema existente disponível. Analise, valide e liste
  erros e oportunidades com evidência.
- **Modo Framework** — sem URL ou schema existente. Gere o JSON-LD parametrizado do tipo
  pedido, declare os campos que o usuário precisa preencher com dados reais e explique o
  impacto de cada um.

## O @graph: o site inteiro como grafo de entidades

A decisão mais importante de arquitetura de schema não é qual tipo usar — é estruturar tudo
num único bloco `@graph` por página, onde cada nó se referencia pelos demais via `@id`. Isso
permite ao Google (e aos LLMs) montar o grafo completo do seu site em vez de processar nós
soltos sem conexão entre si.

Padrão de `@graph` mínimo recomendado em qualquer página:

```json
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
      "@id": "https://exemplo.com/#organization",
      "name": "Nome da Empresa",
      "url": "https://exemplo.com",
      "logo": {
        "@type": "ImageObject",
        "@id": "https://exemplo.com/#logo",
        "url": "https://exemplo.com/logo.png",
        "width": 512,
        "height": 512
      },
      "sameAs": [
        "https://www.linkedin.com/company/nome",
        "https://www.wikidata.org/wiki/QXXXXXX"
      ]
    },
    {
      "@type": "WebSite",
      "@id": "https://exemplo.com/#website",
      "url": "https://exemplo.com",
      "name": "Nome do Site",
      "publisher": { "@id": "https://exemplo.com/#organization" }
    },
    {
      "@type": "WebPage",
      "@id": "https://exemplo.com/pagina/#webpage",
      "url": "https://exemplo.com/pagina/",
      "name": "Título da Página",
      "isPartOf": { "@id": "https://exemplo.com/#website" },
      "about": { "@id": "https://exemplo.com/#organization" },
      "breadcrumb": { "@id": "https://exemplo.com/pagina/#breadcrumb" }
    },
    {
      "@type": "BreadcrumbList",
      "@id": "https://exemplo.com/pagina/#breadcrumb",
      "itemListElement": [
        { "@type": "ListItem", "position": 1, "name": "Home", "item": "https://exemplo.com/" },
        { "@type": "ListItem", "position": 2, "name": "Página", "item": "https://exemplo.com/pagina/" }
      ]
    }
  ]
}
```

Os `@id` funcionam como chaves primárias do grafo. Use o padrão `URL-canônica/#slug-do-nó`
para garantir unicidade e previsibilidade. Referências cruzadas entre nós (como `"publisher":
{ "@id": "..." }`) instruem o Google a fundir os nós em vez de tratá-los como entidades
separadas — é isso que constrói o Knowledge Graph do seu site.

## Stacks por tipo de página

| Tipo de página | Tipos obrigatórios no @graph | Tipos condicionais |
|---|---|---|
| Home / institucional | Organization · WebSite · WebPage · BreadcrumbList | SiteLinksSearchBox (se tiver busca interna) |
| Serviço | Organization · WebSite · Service · WebPage · BreadcrumbList | LocalBusiness (se local) · FAQPage (se FAQ real) |
| Artigo / blog | Organization · WebSite · Article (ou BlogPosting) · Person (autor) · WebPage · BreadcrumbList | FAQPage · speakable |
| Local / home services | LocalBusiness (subtipo correto) · WebSite · WebPage · BreadcrumbList | Review + aggregateRating (só se houver reviews reais) |
| Produto / e-commerce | Product · Offer · Organization · WebPage · BreadcrumbList | AggregateRating · Review |
| FAQ standalone | WebPage · FAQPage · BreadcrumbList | speakable |
| Autor / perfil | Person · WebPage · BreadcrumbList | Organization (empregador) · ItemList (publicações) |

**Princípios universais que valem em todos os tipos:**

- `BreadcrumbList` em toda página, incluindo a home (com único item).
- `Person` autor com `sameAs` apontando para perfis reais verificáveis (LinkedIn, Twitter/X,
  Wikipedia quando existir) — sem `sameAs` o Google não consegue disambiguar o autor.
- `Organization` publisher com `sameAs` para Wikipedia, Wikidata e LinkedIn quando existirem
  — são os sinais mais fortes de consolidação no Knowledge Graph público.
- `mainEntity` e `about` no `WebPage` conectando ao tipo principal da página; `mentions` para
  entidades secundárias citadas mas não centrais.
- `speakable` no bloco do resumo executivo e nas respostas do FAQ — é o sinal para assistentes
  de voz e AI Overviews de onde está a resposta direta.
- `citation` no schema de artigos para as fontes externas que embasam afirmações — reforça
  E-E-A-T e citabilidade por LLMs.

## LocalBusiness: subtipo correto, nunca genérico

`Organization` é para entidades que não têm um estabelecimento físico ou área de atendimento
local. Para qualquer negócio com endereço, telefone ou que atenda clientes presencialmente,
o tipo correto é `LocalBusiness` — ou, melhor ainda, o subtipo específico que o Google
conhece. Usar `Organization` onde cabe `LocalBusiness` é jogar fora o contexto local inteiro.

Subtipos relevantes (escolha o mais específico disponível):

- `HomeAndConstructionBusiness` → construção, reforma, HVAC, elétrica, hidráulica
- `LegalService` → advogados, escritórios jurídicos
- `MedicalBusiness` → clínicas, consultórios, laboratórios
- `AutomotiveBusiness` → oficinas, concessionárias
- `FoodEstablishment` → restaurantes, bares, padarias
- `HealthAndBeautyBusiness` → salões, spas, academias

Campos obrigatórios num `LocalBusiness` bem formado:

```json
{
  "@type": ["LocalBusiness", "HomeAndConstructionBusiness"],
  "@id": "https://exemplo.com/#business",
  "name": "Empresa de Reformas XYZ",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "Av. Paulista, 1578",
    "addressLocality": "São Paulo",
    "addressRegion": "SP",
    "postalCode": "01310-200",
    "addressCountry": "BR"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": -23.5615,
    "longitude": -46.6562
  },
  "telephone": "+551130000000",
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday","Tuesday","Wednesday","Thursday","Friday"],
      "opens": "08:00",
      "closes": "18:00"
    }
  ],
  "areaServed": [
    { "@type": "City", "name": "São Paulo" },
    { "@type": "City", "name": "Guarulhos" }
  ],
  "url": "https://exemplo.com",
  "sameAs": ["https://www.google.com/maps?cid=XXXXX"]
}
```

`areaServed` granular (com entidades `City` ou `State`) é melhor do que um array de strings —
dá ao Google entidades nomeadas, não só texto.

## Integridade de ratings: a seção que não é opcional

Esta é a regra que mais profissionais ignoram e que mais causa dano. O raciocínio é direto:
`aggregateRating` é uma afirmação pública de que clientes reais avaliaram o seu negócio com
uma nota específica. Sem reviews reais visíveis na página para sustentar essa afirmação, ela
é fabricação — e o Google trata fabricação em structured data como *spammy markup*.

**Leia a Seção 6 de `../seo/references/padroes-de-producao.md` antes de marcar qualquer
rating.** O que ela determina, em resumo:

- Nunca fabrique ratings, contagens ou autores de review.
- Se há reviews reais na página, marque cada um com `Review` (autor real, data, corpo do
  texto) e derive o `aggregateRating` deles — nunca o contrário.
- `reviewCount` ≠ `ratingCount`: use cada campo apenas quando os dados de fato diferem.
- O padrão mínimo de `aggregateRating` legítimo:

```json
{
  "@type": "AggregateRating",
  "ratingValue": "4.8",
  "reviewCount": "47",
  "bestRating": "5",
  "worstRating": "1"
}
```

**O risco do 5.0 fixo:** nota máxima fixa em todas as páginas, idêntica para serviços
diferentes em cidades diferentes, com contagens implausíveis, é detectável por análise
automática do Google. Consequências possíveis em ordem crescente de gravidade: perda do
rich snippet de avaliação, ação manual por *structured data spam* listada no Search Console
e, em nichos YMYL (home services, saúde, finanças, direito), risco de remoção da sitewide
do índice.

**Se o operador insistir após o alerta:** documente explicitamente que a decisão é dele e
que o risco foi comunicado — "risco assumido pelo operador, registrado em [data]". O default
desta skill é integridade. Marcação que você não consegue defender numa auditoria manual do
Google não publica.

## Deprecações e restrições ativas

Não invista em tipos que o Google descontinuou ou restringiu:

- **HowTo rich result:** descontinuado em setembro de 2023. O Google não renderiza mais
  o rich result de HowTo para a maioria das consultas. Marcar `HowTo` é peso morto — o
  schema não causa dano, mas também não gera snippet. Não recomende como tática.
- **FAQPage rich result (sites comerciais):** restrito a sites governamentais e de saúde
  desde agosto de 2023. Em site comercial, a marcação `FAQPage` não gera mais o rich result
  de dropdown no Google. Mantenha se o FAQ for real, porque o valor de citação por LLMs
  (cruzado com a skill `seo-geo`) ainda existe — mas ajuste a expectativa do cliente: o
  benefício é de AI Search, não de SERP visual.

## Validação obrigatória antes de publicar

Schema inválido não publica. Ponto. A regra não é negociável porque erro de schema pode
suprimir snippets que já existiam — é regressão, não omissão.

Dois validadores, em ordem:

1. **validator.schema.org** — valida a conformidade com a especificação Schema.org. Zero
   erros. Avisos (warnings) são aceitáveis se documentados; erros, não.
2. **Rich Results Test** (search.google.com/test/rich-results) — valida elegibilidade para
   rich results específicos do Google. Confirma quais tipos o Google consegue renderizar a
   partir do seu schema.

Valide também após qualquer edição. Schema quebra silenciosamente — uma vírgula errada ou
um `@id` mal formatado não aparece no HTML, mas invalida o nó inteiro.

## Como executar

**Modo Execução (URL fornecida):**
1. Extraia o schema existente da página (via WebFetch ou inspeção do HTML).
2. Valide estruturalmente: `@context` presente? `@graph` usado? `@id` em todos os nós? Tipos corretos?
3. Liste erros (campos obrigatórios ausentes, tipos incorretos, ratings fabricados, referências de `@id` quebradas).
4. Liste oportunidades (tipos que faltam para o contexto da página, `sameAs` ausentes, `speakable` não marcado).
5. Entregue o schema corrigido e o que falta fazer.

**Modo Framework (tipo de página pedido, sem URL):**
1. Identifique o tipo de página e o setor (local business? artigo? produto?).
2. Monte o `@graph` completo com todos os nós relevantes para aquele tipo.
3. Marque com `// PREENCHER:` os campos que dependem de dados reais do cliente.
4. Explique o papel de cada nó e o que habilita no Google.

## Entrega padrão

Todo output de schema termina com três blocos:

1. **Schema gerado/corrigido** — JSON-LD completo, pronto para inserir no `<head>` dentro
   de `<script type="application/ld+json">`.
2. **O que falta** — lista dos campos marcados como `// PREENCHER:` e os dados reais
   necessários para completar (URL do perfil do Google Business, coordenadas reais, links de
   `sameAs`, reviews reais para agregação de rating etc.).
3. **Próximo passo** — ação concreta: validar em validator.schema.org, coletar os reviews
   reais antes de adicionar `aggregateRating`, submeter URL ao IndexNow após publicar, ou
   cruzar com `seo-local-rank-and-rent` se o foco for local SEO.
