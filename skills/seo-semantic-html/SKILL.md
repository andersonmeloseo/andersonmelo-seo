---
name: seo-semantic-html
description: HTML5 semântico, Core Web Vitals na marcação, Lighthouse 100 e acessibilidade (WCAG 2.2). Use quando o usuário pedir "HTML semântico", "estrutura semântica da página", "melhorar Core Web Vitals", "Lighthouse 100", "performance da página", "marcação acessível", "LCP/CLS/INP", "tags semânticas certas", ou "esqueleto HTML de SEO".
user-invokable: true
argument-hint: "[url|tipo de página]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.2.0"
  category: seo
---

# HTML5 Semântico, Performance e Acessibilidade

Você é o especialista que audita e constrói a camada de marcação. Enquanto outras sub-skills
decidem o que dizer e para qual entidade, esta decide **como marcar**: escolha de tags,
hierarquia de headings, preloads de LCP, zero CLS, acessibilidade que dobra como SEO.

Declare o modo ao abrir: **Modo Execução** (URL ou HTML fornecido — analise com evidência,
cite o trecho problemático) ou **Modo Framework** (sem acesso — entregue método, critérios
e o que coletar). Nunca misture os dois sem deixar claro a fronteira.

---

## Por que a marcação importa para ranqueamento

`<div class="article">` e `<article>` renderizam igual ao usuário; para o parser do Googlebot
e dos LLMs de AI Overviews, a segunda carrega o sinal "conteúdo principal autossuficiente" e
a primeira é ruído. Em escala (milhares de páginas), esse ruído degrada entendimento de entidade
e topical authority.

CWV integram o ranking signal de Page Experience (não são só desempate) — LCP, CLS e INP têm
raiz na marcação. Limiares e metas de bundle: `../seo/references/padroes-de-producao.md` §5.

---

## Esqueleto HTML5 por tipo de página

### Página de conteúdo (artigo, blog, pillar, hub)

```html
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Keyword Principal · Marca</title>

  <!-- LCP: preload do herói antes de qualquer outra coisa -->
  <!-- type="image/avif" permite que browsers sem suporte ignorem e usem fallback -->
  <link rel="preload" as="image" type="image/avif"
        href="/img/hero.avif"
        imagesrcset="/img/hero-480.avif 480w, /img/hero-960.avif 960w"
        imagesizes="100vw"
        fetchpriority="high">

  <!-- speakable: SOMENTE via JSON-LD (Google não suporta microdata para SpeakableSpecification) -->
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "SpeakableSpecification",
    "cssSelector": ".summary"
  }
  </script>

  <!-- CSS crítico inline (≤14KB) -->
  <style>/* critical CSS aqui */</style>
  <!-- CSS restante async -->
  <link rel="stylesheet" href="/css/main.css" media="print" onload="this.media='all'">
  <noscript><link rel="stylesheet" href="/css/main.css"></noscript>
</head>
<body>

  <!-- skip link: acessibilidade + navegação por teclado -->
  <a href="#main-content" class="skip-link">Ir para o conteúdo principal</a>

  <header>
    <nav aria-label="Navegação principal">
      <!-- links do menu -->
    </nav>
  </header>

  <!-- breadcrumb HTML (JSON-LD separado no <head>) -->
  <nav aria-label="Breadcrumb">
    <ol>
      <li><a href="/">Home</a></li>
      <li><a href="/categoria/">Categoria</a></li>
      <li aria-current="page">Título do Artigo</li>
    </ol>
  </nav>

  <main id="main-content">
    <article>
      <header>
        <h1>Título com a keyword principal</h1>
        <!-- classe .summary é o alvo do cssSelector do SpeakableSpecification acima -->
        <p class="summary">
          Resposta direta à query em 60–80 palavras. Sem enrolação.
        </p>
        <address>
          Por <a href="/autor/anderson-melo/" rel="author">Anderson Melo</a>
        </address>
        <time datetime="2026-06-01">1 de junho de 2026</time>
      </header>

      <!-- herói: sem fetchpriority no <img> — o preload acima já garante prioridade -->
      <!-- width/height obrigatórios para CLS = 0 -->
      <figure>
        <picture>
          <source type="image/avif" srcset="/img/hero-480.avif 480w, /img/hero-960.avif 960w">
          <source type="image/webp" srcset="/img/hero-480.webp 480w, /img/hero-960.webp 960w">
          <img src="/img/hero-960.jpg" alt="Descrição informativa da imagem"
               width="960" height="540">
        </picture>
        <figcaption>Legenda contextual com entidade nomeada.</figcaption>
      </figure>

      <section aria-labelledby="secao-conceito">
        <h2 id="secao-conceito">O que é [conceito central]?</h2>
        <p>…</p>
        <p><dfn>Core Web Vitals</dfn> são as três métricas de experiência do usuário…</p>
      </section>

      <section aria-labelledby="secao-como-fazer">
        <h2 id="secao-como-fazer">Como [fazer algo]</h2>
        <p>…</p>
        <h3>Passo 1: [ação específica]</h3>
        <p>…</p>
      </section>

      <!-- <aside> sem heading filho → aria-label; com heading filho → aria-labelledby -->
      <aside aria-label="Leitura relacionada">
        <!-- links internos tangenciais ao tema principal -->
      </aside>

    </article>
  </main>

  <footer>
    <!-- rodapé global -->
  </footer>

  <!-- JS não crítico: defer ou type="module" -->
  <script src="/js/interactions.js" defer></script>
</body>
</html>
```

### Página de serviço/local (service page, rank-and-rent, programmatic)

Sem `<article>` — conteúdo não é autossuficiente. Use `<main>` + `<section aria-labelledby>` para
cada bloco (benefícios, processo, área, FAQ, reviews) e `<address>` para NAP.

```html
<main id="main-content">
  <section aria-labelledby="hero-heading" class="hero">
    <h1 id="hero-heading">Eletricista em São Paulo — Emergência 24h</h1>
    <p>Descrição direta + diferencial em 1–2 frases.</p>
    <a href="#contato">Solicitar orçamento</a>
  </section>
  <section aria-labelledby="beneficios-heading">
    <h2 id="beneficios-heading">Por que escolher nosso serviço</h2>
    <ul>…</ul>
  </section>
  <section aria-labelledby="faq-heading">
    <h2 id="faq-heading">Perguntas frequentes</h2>
    <!-- <details><summary>Pergunta</summary><p>Resposta</p></details> + FAQPage JSON-LD -->
  </section>
  <address>
    <strong>Elétrica Exemplo Ltda.</strong><br>
    Rua das Flores, 123 — São Paulo, SP 01310-100<br>
    <a href="tel:+551140041234">(11) 4004-1234</a>
  </address>
</main>
```

---

## Hierarquia de headings: certa vs errada

Pular nível sinaliza conteúdo mal organizado; heading longo demais desperdiça sinal de keyword.

**Errado — dois erros clássicos:**
```
h1: Eletricista em São Paulo
  h3: Serviços de instalação        ← pulou h2
    h4: Tomadas e interruptores
  h2: Por que nos escolher
    h4: Equipe certificada          ← pulou h3
```

**Certo — hierarquia linear, headings como perguntas/conceitos:**
```
h1: Eletricista em São Paulo — Emergência 24h (≤68 chars)
  h2: Quais serviços elétricos atendemos? (≤68 chars)
    h3: Instalação de tomadas e interruptores
    h3: Quadro de distribuição e disjuntores
  h2: Como funciona o atendimento emergencial
    h3: Primeiro contato e diagnóstico remoto
    h3: Deslocamento e execução no local
  h2: Área de cobertura em São Paulo
```

Cada H2 funciona como chunk independente: se extraído pelo LLM, faz sentido sozinho.

---

## Landmarks e ARIA mínimos

Roles implícitos: `<header>` = `banner`, `<nav>` = `navigation`, `<main>` = `main`,
`<footer>` = `contentinfo`, `<aside>` = `complementary`. Não duplique com atributo `role`
explícito nesses elementos.

O que adicionar explicitamente:

- `aria-label` em cada `<nav>` quando há mais de uma (ex: "Navegação principal", "Breadcrumb",
  "Rodapé") — sem isso leitores de tela anunciam "navigation" repetido.
- `<section>`/`<aside>` **com heading filho** → `aria-labelledby="id-do-heading"`; **sem
  heading filho** → `aria-label="descrição curta"`.
- Skip link como primeiro filho do `<body>`: `<a href="#main-content" class="skip-link">`.
- `aria-current="page"` no item de breadcrumb e no link ativo do menu.

**Não fazer**: `role="button"` em `<a>` que navega; `role="article"` em `<div>` quando cabe
`<article>`; `aria-hidden="true"` em conteúdo que precisa ser lido.

---

## Core Web Vitals na marcação (snippets operacionais)

Ver definições completas e limiares de campo (CrUX) em `../seo/references/padroes-de-producao.md` §5.

### LCP — alvo < 2,0s em lab; limiar 'Good' de campo (CrUX) = 2,5s

LCP candidate típico = imagem do herói. Descoberta via preload no `<head>` — CSS
`background-image` e JS são tarde demais para o preload scanner.

```html
<!-- No <head>, ANTES de qualquer folha de estilos -->
<!-- type="image/avif": browsers sem suporte ignoram este preload e usam o fallback do <picture> -->
<link rel="preload" as="image" type="image/avif"
      href="/img/hero.avif"
      imagesrcset="/img/hero-480.avif 480w, /img/hero-1200.avif 1200w"
      imagesizes="(max-width: 600px) 100vw, 1200px"
      fetchpriority="high">
```

CSS crítico inline (≤14KB); título do herói sempre server-side (nunca depende de JS).

### CLS = 0 — dimensões em toda mídia

`width`/`height` em toda imagem, vídeo e iframe — o browser reserva espaço antes de carregar.
Containers dinâmicos (banner, embed): `min-height` fixo no CSS.

```html
<img src="/img/foto.avif" alt="Descrição" width="800" height="450"
     loading="lazy" decoding="async">
<div style="min-height: 90px;" class="ad-slot">…</div>
```

Fontes: `font-display: swap` previne FOIT; `size-adjust` na fallback elimina shift.

```css
@font-face {
  font-family: 'MinhaFonte';
  src: url('/fonts/minha-fonte.woff2') format('woff2');
  font-display: swap;
}

/* fallback calibrada para zero shift */
/* AVISO: os valores abaixo são ilustrativos — calcule para a sua fonte específica
   com Font Style Matcher (https://meowni.ca/font-style-matcher/) antes de aplicar.
   Valores errados INTRODUZEM CLS em vez de eliminá-lo. */
@font-face {
  font-family: 'MinhaFonte-Fallback';
  src: local('Arial');
  size-adjust: 106%;       /* ilustrativo */
  ascent-override: 90%;    /* ilustrativo */
}
```

### INP < 200ms — zero JS bloqueante + long tasks quebradas

INP mede o **pior tempo de resposta entre TODAS as interações da sessão (P98)** — não
apenas a primeira. É o sucessor do FID (descontinuado).

`defer` reduz bloqueio no carregamento mas **não resolve INP de event handlers caros**.
Para INP, quebre long tasks com `scheduler.yield()` (ou `setTimeout(0)`) e evite layout
thrashing (ler e escrever o DOM no mesmo frame).

```html
<!-- Scripts não críticos: defer (mantém ordem, executa após parse) -->
<script src="/js/analytics.js" defer></script>

<!-- Módulos ES: type="module" implica defer automaticamente -->
<script type="module" src="/js/app.js"></script>

<!-- Third-party analytics: só após interação, nunca no carregamento inicial -->
<script>
  document.addEventListener('click', function initAnalytics() {
    const s = document.createElement('script');
    s.src = 'https://analytics.example.com/a.js';
    document.head.appendChild(s);
    document.removeEventListener('click', initAnalytics);
  }, { once: true });
</script>
```

Embeds de vídeo: facade (poster estático + load on click) — iframe real só na interação, poupa ~500KB de JS de terceiros.

---

## Imagens: `<picture>` com AVIF + WebP

AVIF entrega 40–50% menos bytes que JPEG; suporte atual: [caniuse.com/avif](https://caniuse.com/avif).
Fallback obrigatório via `<picture>`.

```html
<picture>
  <source
    type="image/avif"
    srcset="/img/produto-400.avif 400w, /img/produto-800.avif 800w, /img/produto-1200.avif 1200w"
    sizes="(max-width: 600px) 100vw, (max-width: 900px) 50vw, 800px">
  <source
    type="image/webp"
    srcset="/img/produto-400.webp 400w, /img/produto-800.webp 800w, /img/produto-1200.webp 1200w"
    sizes="(max-width: 600px) 100vw, (max-width: 900px) 50vw, 800px">
  <!-- JPEG: último fallback; width/height obrigatórios -->
  <img src="/img/produto-800.jpg"
       alt="Nome do produto em contexto de uso — descritivo para leitores de tela e Googlebot"
       width="800" height="600"
       loading="lazy"
       decoding="async">
</picture>
```

Regra de `alt`: imagem informativa → alt descritivo com entidade nomeada e contexto. Imagem
decorativa (separador, ícone sem semântica) → `alt=""` para que leitores de tela a ignorem.
`alt` ausente (sem atributo) é erro de acessibilidade — diferente de `alt=""`.

---

## Auditar uma página (Modo Execução)

Ordem de verificação — para cada achado: trecho exato, impacto e correção precisa.

1. **Tags semânticas**: conteúdo principal em `<article>`/`<main>`? `<div>` substituindo
   `<section>`, `<aside>`, `<nav>`?
2. **Headings**: exatamente 1 `<h1>`? Nível pulado? Heading > 68 chars? Extraia a árvore.
3. **LCP**: preload `<link rel="preload" as="image" type="image/avif" fetchpriority="high">`
   no `<head>`? `<img>` do herói tem `fetchpriority="high"` duplicando o preload (remover)?
   Título server-side (não via JS)?
4. **JS/INP**: `<script src>` sem `defer`/`async`? Third-party no `<head>` sem lazy load?
   Event handlers com long tasks (> 50ms) ou layout thrashing?
5. **Fontes**: self-hosted woff2? `font-display: swap`? `size-adjust` calibrado na fallback?
6. **Imagens**: `width`/`height` em todas? LCP usa AVIF? `loading="lazy"` abaixo da dobra?
   `alt` descritivo ou `alt=""` correto?
7. **ARIA**: skip link? Múltiplas `<nav>` com `aria-label` distintos? `aria-labelledby` onde
   há heading filho; `aria-label` onde não há? `aria-current="page"` no breadcrumb?
8. **speakable**: `SpeakableSpecification` via microdata (`itemscope`/`itemtype` no HTML) →
   erro grave; Google só aceita via JSON-LD com `cssSelector`.

---

## Validação: o que "aprovado" significa

| Ferramenta | Critério |
|---|---|
| validator.w3.org | Zero erros |
| Lighthouse desktop + mobile | 100 / 100 / 100 / 100 |
| axe DevTools | Zero violações |
| PageSpeed Insights (lab) | LCP < 2,0s · CLS = 0 · INP < 200ms |
| CrUX / Search Console (campo) | LCP < 2,5s · CLS < 0,1 · INP < 200ms |

Lab perfeito + campo ruim → throttling de rede, TTFB alto ou third-party fora da janela
de lab. Ambos precisam estar verdes.

---

## Entrega

**Modo Execução:** diagnóstico por seção (semântica → headings → LCP → CLS/INP → imagens →
acessibilidade), cada achado com evidência citada e correção precisa. Termine indicando qual
item tem maior impacto e deve ser resolvido primeiro.

**Modo Framework:** esqueleto HTML5 adaptado ao tipo de página informado, com anotações
explicando cada escolha. Inclua checklist de validação e o próximo passo concreto para
medir o resultado após a publicação.
