# Padrões de produção

Carregue este arquivo antes de **gerar ou marcar** qualquer entregável (HTML, schema,
conteúdo, página). Ele define o que separa um output de elite de um genérico. Vale para
todas as skills do plugin.

## Índice
1. HTML5 semântico
2. Padrão editorial
3. Estruturação para LLM e featured snippets
4. Information Gain
5. Performance (alvo Lighthouse 100)
6. Integridade de ratings e reviews
7. Checklist pré-publicação

---

## 1. HTML5 semântico

O Google e os LLMs extraem significado da marcação. Tag genérica onde existe tag
semântica é informação jogada fora.

**Use por contexto:**
- `<header>` global · `<nav aria-label="...">` em toda navegação · `<main>` única por página
- `<article>` (conteúdo principal) · `<section>` (divisão temática, sempre com `<h2>`) · `<aside>` (tangencial)
- `<footer>` global · `<time datetime="ISO-8601">` em toda data · `<address>` em autoria/contato
- `<figure>`+`<figcaption>` em imagens com contexto · `<dfn>` na primeira menção de termo técnico
- `<abbr title="...">` em siglas · `<cite>` em referências · `<mark>` em dados/estatísticas/números
- `<dl>/<dt>/<dd>` em definições (LLMs extraem com prioridade)

**Evite onde há alternativa semântica:** `<div>` no lugar de `article/section/aside/header/footer/nav`;
`<span>` no lugar de `time/address/cite/abbr/mark/dfn`; `<br>` para espaçamento.

**Hierarquia de headings:** um único `<h1>` com a keyword principal; sem pular níveis
(h2→h4 é erro); H2/H3 com no máximo ~68 caracteres, cada um expressando uma pergunta ou
conceito atômico.

## 2. Padrão editorial

- **Pirâmide invertida:** resposta direta primeiro. Primeiro parágrafo de 60-80 palavras
  responde a query.
- Cada parágrafo: 2-4 frases, autossuficiente (funciona como chunk isolado).
- Toda seção fecha com parágrafo — nunca termina em lista.
- **Entidades nomeadas**, não pronomes ambíguos — LLMs extraem por nome.

**Tom:** profissional, direto, técnico. Sem clichês ("Além disso", "Vale ressaltar",
"Em conclusão"). Sem seção "Conclusão". Sem emoji no corpo.

**Comprimento mínimo (ajuste ao tipo):** cluster 1.500 · hub 2.000 · pillar 2.500 ·
página de serviço 1.200 · página programática conforme o template (mínimo ~600 com
variação semântica real).

## 3. Estruturação para LLM e featured snippets

Para ser citado por IA e capturar snippet:
- "Resumo executivo" no topo (60-100 palavras) com marcação `speakable`.
- Cada H2 reproduz a pergunta que responde; logo abaixo, 40-60 palavras respondendo direto.
- Dados em `<mark>`; termos em `<dfn>` na primeira menção; definições em `<dl>/<dt>/<dd>`.
- Fontes externas com `<cite>` + link.
- Listas: `<ol>`/`<ul>` com 4-8 itens começando por verbo/substantivo.
- Tabelas reais com `<thead>` e `<th scope="col">`.

## 4. Information Gain

Information Gain separa o conteúdo que rankeia em 2026 do descartável: toda página
adiciona valor que **não está nas SERPs atuais**.

**Tipos válidos:** dado primário (com N declarado) · framework original nomeado · tabela
comparativa com critérios inéditos · estudo de caso com números · contraponto fundamentado
ao consenso · visualização exclusiva · calculadora embutida · decision tree · erros comuns +
correção · glossário com definições próprias.

**Mínimos:** cluster 3 elementos · hub 4 · pillar 5.

**Regra anti-fingimento:** sem dado primário fornecido, **não invente** — peça. Conteúdo sem
IG real não publica. Em programmatic, o IG vem do **template + dataset estruturado** (dados
únicos por página: estatísticas locais, faixas por cidade, especificidades regionais), não
de texto editorial único por página — confirme qual dataset diferencia cada página.

## 5. Performance (alvo Lighthouse 100)

- **LCP < 2,0s:** herói em AVIF com dimensões fixas e `<link rel="preload" as="image" fetchpriority="high">`;
  texto do herói 100% server-side; CSS crítico inline (até ~14KB), resto async.
- **CLS = 0:** `width`/`height` em imagens, vídeos, iframes; `min-height` em containers
  dinâmicos; `font-display: swap` + `size-adjust`.
- **INP < 200ms:** zero JS bloqueante no carregamento; `defer` em scripts não críticos.
- **Bundle:** JS inicial < 100KB gzipped; code splitting por rota; lazy load abaixo da dobra.
- **Servidor:** HTTP/2 ou /3; Brotli; cache 1 ano em assets versionados; CDN.
- **Third-party:** zero scripts no carregamento inicial; analytics/pixels só após interação;
  embeds (YouTube etc.) via facade. Fontes self-hosted — nunca Google Fonts via CDN.

## 6. Integridade de ratings e reviews

Esta é uma decisão de reputação. A escola desta skill é **marcação que sustenta**: o schema
de avaliação reflete avaliações que **existem de verdade** e que estão visíveis na própria
página.

**Regras:**
- **Nunca fabrique** ratings, contagens ou autores de review. Marcação de avaliação sem
  reviews reais por trás é exatamente o que o Google classifica como *spammy structured markup*.
- Se há reviews reais, marque-os com `Review` (autor real, data, corpo) e derive o
  `aggregateRating` deles — não o contrário.
- Use o subtipo correto (`LocalBusiness` e derivados como `LegalService`, `MedicalBusiness`,
  `HomeAndConstructionBusiness`), nunca `Organization` genérico, para que o rating faça
  sentido contextual.
- `reviewCount` e `ratingCount` só diferem quando você de fato tem as duas coisas.

**O risco do "5.0 fixo" (registre quando aplicável):** um `aggregateRating` com nota máxima
fixa, igual em todas as páginas, ou com contagens implausíveis, é detectável por filtros
automáticos do Google — consequências possíveis: perda do rich snippet, **ação manual** por
*structured data spam* no Search Console e, em casos extremos, remoção do índice. O risco é
maior em nichos YMYL (saúde, finanças, direito) e home services.

**Se o cliente/operador insistir** numa configuração inflada mesmo após o alerta: documente
que é decisão dele e que o risco foi comunicado ("risco assumido pelo operador, registrado em
[data]"). O default desta skill é integridade — marcação que você defenderia numa auditoria
manual do Google.

## 7. Checklist pré-publicação

Falhou em algum item → refaz.

**Estrutura:** HTML5 válido (sem erro no validator.w3.org) · 1 `<h1>` com keyword ·
hierarquia sem pulos · breadcrumb HTML + JSON-LD · resposta direta nos primeiros 80 termos ·
"Resumo executivo" com `speakable`.

**Schema:** validado em validator.schema.org e Rich Results Test · tipo correto +
`BreadcrumbList` + `Person` autor + `Organization` publisher · `sameAs` apontando para perfis
reais · ratings conforme a seção 6.

**Conteúdo:** mínimo de palavras e de IG atingidos · sem clichês · sem "Conclusão" · listas
fechadas por parágrafo · links internos com âncoras semânticas variadas · fontes com `<cite>`.

**Performance:** Lighthouse 100/100/100/100 desktop e mobile · LCP em AVIF com preload ·
JS < 100KB gzipped · zero third-party no carregamento inicial · fontes self-hosted.

**SEO técnico:** title 50-60 caracteres com keyword · description 140-155 · canonical correto ·
hreflang quando aplicável · Open Graph + Twitter Card · OG image 1200×630 · página no sitemap.xml.

**Acessibilidade (WCAG 2.2 AA):** contraste 4.5:1 · navegação por teclado · `alt` descritivo
(informativas) e `alt=""` (decorativas) · foco visível · `<label>` em formulários.

**LLM/AI:** parágrafos autossuficientes · entidades nomeadas · dados em `<mark>` · termos em
`<dfn>` · FAQ com perguntas reais.
