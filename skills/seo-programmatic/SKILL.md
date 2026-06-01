---
name: seo-programmatic
description: SEO programático em escala (centenas a milhões de páginas data-driven) com travas anti-thin e near-duplicate. Use quando o usuário pedir "gerar páginas em escala", "programmatic SEO", "milhares de páginas de cidade", "páginas de serviço x cidade", "portal programático", "páginas dinâmicas a partir de planilha", "SEO em escala", "evitar conteúdo thin/duplicado em escala", ou "index bloat".
user-invokable: true
argument-hint: "[url|plano]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# SEO Programático — geração de páginas em escala

Você está na sub-skill de SEO programático. O contexto já foi roteado pelo orquestrador `seo`,
que sabe que o trabalho aqui é escala: centenas ou milhares de páginas geradas a partir de
um dataset + template, não de redação editorial individual.

Antes de qualquer coisa, carregue `../seo/references/padroes-de-producao.md`. Todo output
desta skill — HTML, schema, template, especificação de conteúdo — obedece àquele documento.

---

## A linha vermelha: escala sem valor é passivo, não ativo

O Google classifica *scaled content abuse* como spam. A penalidade atinge todo o domínio,
não só as páginas ruins. Isso não é teoria — é o que as Search Quality Rater Guidelines
e as ações manuais de 2024-2025 mostraram repetidamente em nichos de home services,
finanças e jurídico.

O problema não é escala em si. É escala **sem razão de existir por página**. Uma página que
apenas troca "São Paulo" por "Campinas" no template, sem nenhum dado diferente, não ajuda
ninguém a encontrar o que precisa. O Google detecta isso via similaridade de conteúdo,
via comportamento do usuário e via análise de padrões no dataset de treinamento.

A pergunta que esta skill sempre faz antes de gerar: **o que esta página sabe que a
página-irmã não sabe?** Se a resposta for "nada além do nome da cidade", há um problema
de dataset para resolver antes de um problema de template para escrever.

---

## O que define Information Gain em programmatic

Em conteúdo editorial, o IG vem de dado primário, estudo de caso, framework original.
Em programmatic, a regra muda: **o template é fixo; o dataset é o IG**. Isso é legítimo
e escalonável — desde que o dataset contenha dados que variam de verdade entre páginas.

Dados que criam variação semântica real (exemplos):

- Código geográfico oficial (IBGE, FIPS, postcode, NUTS)
- População, PIB per capita, IDH municipal
- Regulação ou legislação local (alvará, licença profissional, lei estadual)
- Faixas de preço reais por cidade/estado (coletadas, não estimadas)
- Distância ou tempo de deslocamento até polo de serviço
- Índice climático regional (relevante para HVAC, construção, saúde)
- Número de concorrentes locais ativos (coleta via API/crawl)
- Taxa de criminalidade ou estatísticas de segurança (seguros, fechaduras)
- Vizinhos geográficos: cidades que compartilham fronteira ou região administrativa
- Código CRM, CRO, OAB, CREA regional (nichos regulados)

O que **não** conta como dado único: trocar o nome da cidade, o estado ou o slug. Isso é
substituição de token, não variação semântica.

---

## Dois modos de operação — declare qual

Assim como o orquestrador, esta skill opera em um de dois modos:

**Modo Execução** — o dataset foi fornecido (planilha, JSON, CSV, conexão com banco).
Aqui a skill gera: template, lotes de páginas, especificação de schema, sitemap segmentado,
estratégia de internal linking. Entrega páginas reais, não só orientações.

**Modo Framework** — o dataset não existe ou está incompleto. Aqui a skill não inventa
dados: entrega o blueprint do que coletar, como estruturar o JSON/CSV, quais APIs ou
fontes públicas usar para cada vertical, e o template pronto para receber os dados quando
chegarem. Listar claramente o que está faltando e o que cada campo vai ativar.

Nunca misture os dois. Se parte do dataset chegou, execute o que der e aponte o que falta
para completar os lotes restantes.

---

## Workflow padrão (execute nesta ordem)

### Passo 1 — Confirmar entidade e tipo de página

Antes de escrever uma linha de template, defina:

- Qual é a **entidade central** de cada página? (ex.: "Empresa de desentupimento em [cidade]",
  "Plano de saúde para MEI em [estado]", "Advogado trabalhista em [bairro]")
- Qual é o tipo de página no mapa topical? (pillar / hub / cluster / serviço-cidade / local)
- A página é folha (sem filhas) ou nó (tem páginas filhas que herdam autoridade dela)?

Sem entidade definida, não há âncora para o schema, para os links internos nem para o
title/H1. Pergunte se não estiver claro.

### Passo 2 — Exigir o dataset

Solicite o arquivo de dados com as variáveis por página. Especificação mínima necessária:

```
id          identificador único (slug)
city        nome da cidade/localidade
state       estado ou UF
service     serviço principal desta página
modifier    modificador (ex.: "residencial", "industrial", "urgência")
```

Além desses campos básicos, liste os campos de IG que a vertical precisa (ver seção
anterior). Se o operador não tiver o dataset, entre em Modo Framework e entregue a
especificação do arquivo para ele preencher ou automatizar a coleta.

### Passo 3 — Definir a estratégia de variação semântica

Com o dataset em mãos, meça a entropia antes de gerar. Calcule (mesmo que manualmente,
comparando amostras) qual porcentagem do conteúdo do `<main>` varia entre páginas-irmãs.

Alvo mínimo de variação: **≥ 30% do conteúdo do `<main>` deve ser único por página**,
descontando header, footer, nav e componentes estruturais fixos.

Se o dataset só suporta 10-15% de variação (nome da cidade + slug), o template está
thin por design. A solução não é escrever mais texto estático — é enriquecer o dataset
ou reduzir o escopo (cobrir menos cidades com mais dados por cidade).

Estratégias de variação que funcionam:

- Parágrafo de contexto local gerado a partir de campos do dataset (regulação, faixas,
  vizinhos)
- Tabela comparativa de preços por cidade, construída diretamente do dataset
- Seção "Cidades atendidas na região" com as cidades vizinhas (campo `neighbors`)
- FAQ com perguntas geradas dinamicamente a partir de modificadores do serviço
- Trust signals locais: associação de classe regional, sindicato patronal, vigilância sanitária

### Passo 4 — Gerar em lotes

Gere **no máximo 50 páginas por lote**. Ao final de cada lote:

1. Reporte quantas foram geradas, quantas passaram no quality gate, quantas ficaram com
   marcação `noindex` preventivo.
2. Mostre uma amostra de 3 páginas de cidades distintas para o operador revisar a variação.
3. Aguarde confirmação antes do próximo lote.

Isso não é burocracia: é controle de qualidade escalonável. Um erro de template que passa
despercebido em lote de 50 não precisa ser corrigido em 10.000.

### Passo 5 — Aplicar `noindex` em páginas sem variação suficiente

Qualquer página que, após geração, apresente menos de **~20% de conteúdo único no `<main>`**
recebe `<meta name="robots" content="noindex, follow">` e é excluída do sitemap.

Isso não é punição — é higiene de índice. Páginas `noindex` podem existir por razões
operacionais (área de serviço que o cliente atende mas onde não tem histórico nem dados).
O Google não as indexa, o Googlebot não desperdiça crawl budget nelas, e o índice permanece
limpo. Quando o dataset for enriquecido, basta remover o `noindex` e resubmeter.

---

## Arquitetura de URL

O padrão de URL em programmatic precisa ser:

1. **Consistente**: mesma estrutura em todas as páginas do tipo.
2. **Semântico**: slugs em palavras reais, não IDs numéricos.
3. **Plano o suficiente**: evite `/<servico>/<estado>/<cidade>/<bairro>/<modificador>/` —
   cinco níveis de profundidade para uma página folha é profundo demais para crawl e para
   PageRank fluir.

Padrões recomendados por tipo de página:

| Tipo | Padrão | Exemplo |
|---|---|---|
| Serviço × cidade | `/<servico>/<cidade-uf>/` | `/desentupimento/campinas-sp/` |
| Serviço × bairro | `/<servico>/<cidade-uf>/<bairro>/` | `/desentupimento/sao-paulo-sp/moema/` |
| Profissional × cidade | `/<profissao>/<cidade-uf>/` | `/advogado-trabalhista/curitiba-pr/` |
| Produto × localidade | `/<produto>/<regiao>/` | `/plano-odontologico/sul-de-minas/` |

Evite incluir o estado como nível separado quando a cidade já é única no dataset. Cria
profundidade sem valor.

---

## Sitemap segmentado

Com dezenas de milhares de URLs, um único `sitemap.xml` fica pesado e ineficiente para
rastreamento. Segmente por tipo:

```xml
<!-- sitemap-index.xml -->
<sitemapindex>
  <sitemap><loc>/sitemap-servico-cidade.xml</loc></sitemap>
  <sitemap><loc>/sitemap-servico-bairro.xml</loc></sitemap>
  <sitemap><loc>/sitemap-hub.xml</loc></sitemap>
</sitemapindex>
```

Limite de 50.000 URLs por arquivo de sitemap (regra do protocolo). Use `<lastmod>` apenas
quando a data refletir uma mudança real — datas falsas degradam a confiança do bot.

Não inclua no sitemap páginas com `noindex`. O Google ignora a contradição (indexar via
sitemap e noindex via meta), mas é sinal de desorganização que aparece no GSC.

---

## Internal linking automático

Links internos em programmatic não podem ser manuais — precisam ser gerados pelo mesmo
sistema que gera as páginas. Padrões obrigatórios:

**Cidade → cidades vizinhas:** cada página de cidade linka para as N cidades do campo
`neighbors` no dataset. Texto âncora: nome da cidade, nunca "clique aqui" ou "saiba mais".

**Serviço → serviços relacionados:** se o dataset tem vínculo entre serviços (ex.:
desentupimento → hidrojateamento), o template inclui bloco de serviços relacionados
gerado a partir dessa relação.

**Hub → clusters filhos:** o hub da cidade linka para todas as páginas de serviço naquela
cidade. Os clusters linkam de volta para o hub.

**Evite explosão de links:** um `<nav>` ou `<aside>` com 200 links internos dilui o
PageRank e parece spam. Limite a 10-15 links contextuais por página, além da navegação global.

---

## Controle de index bloat

Index bloat é o acúmulo de páginas indexadas que não trazem tráfego, não têm backlinks
e não satisfazem nenhuma intenção real. O custo: crawl budget desperdiçado, diluição
de autoridade de domínio, e sinal de baixa qualidade agregada.

Monitore mensalmente no GSC:

1. Total de URLs submetidas × total indexadas.
2. URLs indexadas com zero cliques nos últimos 90 dias.
3. Páginas com CTR médio < 0,5% e impressões baixas.

Para cada grupo problemático, decida: enriquecer o dataset e reindexar; consolidar
(301 para a página-pai mais forte); ou `noindex` definitivo.

A meta não é indexar tudo — é indexar o que o Google considera digno de ranking. Menos
páginas de qualidade superam mais páginas mediocres em autoridade de domínio.

---

## Quality gate por escala

O controle de qualidade muda conforme o volume. Estas são as paradas obrigatórias:

| Volume de páginas | Ação da skill |
|---|---|
| 1–29 | Gera normalmente; aplica checklist de `padroes-de-producao.md` em cada página. |
| 30–49 | Avisa o operador que está entrando em escala intermediária; confirma que o dataset tem variação suficiente para o lote. |
| 50+ | **Exige** justificativa explícita de unicidade: qual campo do dataset diferencia cada página? Se o operador não souber responder, entra em Modo Framework antes de continuar. |
| 500+ | Solicita amostragem: 10 páginas aleatórias do lote para revisão de variação antes de gerar o restante. |
| 5.000+ | O dataset **é** a justificativa — confirme qual arquivo de dados está sendo usado, qual versão, e quantos campos de IG ele contém. Registre isso no relatório. |

---

## Schema em programmatic

Cada página gerada precisa de schema correto. Em programmatic, o schema é parte do
template — os campos de valor (endereço, coordenadas geo, telefone, área de serviço)
vêm do dataset.

Padrões obrigatórios por tipo de página programática:

**Serviço local:** `LocalBusiness` (ou subtipo) + `Service` + `BreadcrumbList`.
Os campos `geo`, `address`, `areaServed` vêm do dataset — nunca fixos no template.

**Profissional × cidade:** `Person` + `ProfessionalService` + `BreadcrumbList`.
Se o nicho é regulado (médico, advogado, engenheiro), use o subtipo correto
(`LegalService`, `MedicalBusiness`, etc.).

**FAQ dinâmico:** se o template inclui FAQ gerado a partir do dataset, marque com
`FAQPage` + `Question` + `acceptedAnswer`. Perguntas que não variam entre páginas
são perguntas genéricas — úteis, mas não IG.

O `aggregateRating` segue a política definida em `../seo/references/padroes-de-producao.md`
seção 6. Esta skill não sobrescreve aquela política.

---

## Entrega

Todo trabalho desta skill termina com **próximo passo concreto**, nunca com resumo
motivacional. O formato de entrega depende do modo:

**Modo Execução:** páginas geradas em lote (HTML ou especificação de template + variáveis
por página) + sitemap do lote + lista de páginas com `noindex` preventivo + amostra
de 3 páginas para revisão + confirmação de próximo lote.

**Modo Framework:** especificação do dataset (campos obrigatórios, fonte sugerida para
cada campo, formato JSON/CSV) + template base com variáveis marcadas + estimativa de
variação semântica por página + instrução de qual ferramenta ou script usar para
popular o dataset.

Tudo que for gerado segue `../seo/references/padroes-de-producao.md` sem exceção.
