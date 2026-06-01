---
name: seo-semantic-html
description: HTML5 semântico, Core Web Vitals na marcação, Lighthouse 100 e acessibilidade (WCAG 2.2). Use quando o usuário pedir "HTML semântico", "estrutura semântica da página", "melhorar Core Web Vitals", "Lighthouse 100", "performance da página", "marcação acessível", "LCP/CLS/INP", "tags semânticas certas", ou "esqueleto HTML de SEO".
user-invokable: true
argument-hint: "[url|tipo de página]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
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

Googlebot e os LLMs que alimentam AI Overviews não "veem" a página — eles processam o DOM.
Uma `<div class="article">` e um `<article>` podem renderizar idênticos ao usuário, mas para
o parser semântico a segunda carrega o sinal "este é o conteúdo principal autossuficiente";
a primeira é ruído estrutural. Multiplicado por milhares de páginas, esse ruído degrada o
entendimento da entidade e o topical authority do domínio.

Além disso, Core Web Vitals são fator de desempate de ranking confirmado desde 2021 —
e continuam sendo sinal de qualidade na era de AI Search. LCP ruim significa que o crawler
espera. CLS alto sinaliza instabilidade. INP alto penaliza UX em campo (CrUX). Os três têm
raiz na marcação: dimensões ausentes, JS bloqueante, preload faltando.

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
  <link rel="preload" as="image" href="/img/hero.avif" fetchpriority="high"
        imagesrcset="/img/hero-480.avif 480w, /img/hero-960.avif 960w"
        imagesizes="100vw">
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
        <!-- resumo executivo com speakable -->
        <p class="summary" itemscope itemtype="https://schema.org/SpeakableSpecification">
          Resposta direta à query em 60–80 palavras. Sem enrolação.
        </p>
        <address>
          Por <a href="/autor/anderson-melo/" rel="author">Anderson Melo</a>
        </address>
        <time datetime="2026-06-01">1 de junho de 2026</time>
      </header>

      <!-- imagem do herói fora do preload: dimensões fixas para CLS = 0 -->
      <figure>
        <picture>
          <source type="image/avif" srcset="/img/hero-480.avif 480w, /img/hero-960.avif 960w">
          <source type="image/webp" srcset="/img/hero-480.webp 480w, /img/hero-960.webp 960w">
          <img src="/img/hero-960.jpg" alt="Descrição informativa da imagem"
               width="960" height="540" fetchpriority="high">
        </picture>
        <figcaption>Legenda contextual com entidade nomeada.</figcaption>
      </figure>

      <section aria-labelledby="secao-conceito">
        <h2 id="secao-conceito">O que é [conceito central]?</h2>
        <p>…</p>
        <!-- termos técnicos na primeira menção -->
        <p><dfn>Core Web Vitals</dfn> são as três métricas de experiência do usuário…</p>
      </section>

      <section aria-labelledby="secao-como-fazer">
        <h2 id="secao-como-fazer">Como [fazer algo]</h2>
        <p>…</p>
        <h3>Passo 1: [ação específica]</h3>
        <p>…</p>
      </section>

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

A diferença estrutural principal: `<article>` cede lugar a `<main>` direto com seções
temáticas, pois o conteúdo não é um artigo autossuficiente — é a apresentação de uma
oferta de serviço. Use `<address>` para NAP e `<section>` com heading próprio para cada
bloco (benefícios, processo, área de cobertura, FAQ, reviews).

```html
<main id="main-content">

  <!-- herói: texto server-side, nunca via JS -->
  <section aria-labelledby="hero-heading" class="hero">
    <h1 id="hero-heading">Eletricista em São Paulo — Emergência 24h</h1>
    <p>Descrição direta do serviço e diferencial em 1–2 frases.</p>
    <a href="#contato">Solicitar orçamento</a>
  </section>

  <section aria-labelledby="beneficios-heading">
    <h2 id="beneficios-heading">Por que escolher nosso serviço</h2>
    <ul>
      <li>…</li>
    </ul>
  </section>

  <section aria-labelledby="processo-heading">
    <h2 id="processo-heading">Como funciona o atendimento</h2>
    <ol>…</ol>
  </section>

  <section aria-labelledby="area-heading">
    <h2 id="area-heading">Área de cobertura</h2>
    <!-- lista de bairros/cidades com links internos -->
  </section>

  <section aria-labelledby="faq-heading">
    <h2 id="faq-heading">Perguntas frequentes</h2>
    <!-- cada item: <details><summary>Pergunta</summary><p>Resposta</p></details>
         ou marcação explícita + FAQPage JSON-LD -->
  </section>

  <!-- NAP estruturado -->
  <address>
    <strong>Elétrica Exemplo Ltda.</strong><br>
    Rua das Flores, 123 — São Paulo, SP 01310-100<br>
    <a href="tel:+551140041234">(11) 4004-1234</a>
  </address>

</main>
```

---

## Hierarquia de headings: certa vs errada

O Google usa a árvore de headings para entender a estrutura tópica da página. Pular nível
sinaliza conteúdo mal organizado; heading longo demais desperdiça sinal de keyword.

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

Elementos HTML5 têm **roles implícitos**: `<header>` mapeia para `banner`, `<nav>` para
`navigation`, `<main>` para `main`, `<footer>` para `contentinfo`, `<aside>` para
`complementary`. Não duplique com `role="navigation"` num `<nav>` — é redundante.

O que adicionar explicitamente:

- `aria-label` em cada `<nav>` quando há mais de uma na página (ex: "Navegação principal",
  "Breadcrumb", "Navegação do rodapé"). Sem isso, leitores de tela anunciam "navigation"
  repetido sem diferenciação.
- `aria-labelledby="id-do-heading"` em `<section>` e `<aside>` sem heading de label óbvio.
- Skip link visível ao foco: `<a href="#main-content" class="skip-link">` posicionado como
  primeiro filho do `<body>`. Usuários de teclado e leitores de tela dependem dele para não
  repetir toda a navegação a cada página.
- `aria-current="page"` no item de breadcrumb e no link ativo do menu.

O que **não** fazer: `role="button"` num `<a>` que navega (use `<a>`); `role="article"` num
`<div>` quando você pode usar `<article>`; `aria-hidden="true"` em conteúdo que precisa ser
lido.

---

## Core Web Vitals na marcação (snippets operacionais)

### LCP < 2,0s — herói carregado antes de tudo

O LCP candidate típico é a imagem do herói. O browser precisa descobri-la o mais cedo
possível no HTML — não via CSS `background-image` (invisível para o preload scanner) e não
via JS (tarde demais).

```html
<!-- No <head>, ANTES de qualquer folha de estilos -->
<link rel="preload" as="image"
      href="/img/hero.avif"
      imagesrcset="/img/hero-480.avif 480w, /img/hero-1200.avif 1200w"
      imagesizes="(max-width: 600px) 100vw, 1200px"
      fetchpriority="high">
```

CSS crítico inline evita render-blocking; limite de ~14KB mantém o first byte rápido.
Tudo acima da dobra server-side: o título do herói nunca pode depender de JS para aparecer.

### CLS = 0 — dimensões em toda mídia

CLS de 0 começa com `width` e `height` declarados em toda imagem, vídeo e iframe — o
browser reserva o espaço antes de carregar o recurso.

```html
<!-- width/height obrigatórios: evitam reflow quando a imagem carrega -->
<img src="/img/foto.avif" alt="Descrição" width="800" height="450"
     loading="lazy" decoding="async">

<!-- Container dinâmico (ex: banner de anúncio, embed): reserve altura mínima -->
<div style="min-height: 90px;" class="ad-slot">…</div>
```

Para fontes customizadas: `font-display: swap` previne FOIT; `size-adjust` na regra
`@font-face` da fallback elimina o shift de layout quando a webfont substitui a fallback.

```css
@font-face {
  font-family: 'MinhaFonte';
  src: url('/fonts/minha-fonte.woff2') format('woff2');
  font-display: swap;
}

/* fallback com size-adjust calibrado para zero shift */
@font-face {
  font-family: 'MinhaFonte-Fallback';
  src: local('Arial');
  size-adjust: 106%;
  ascent-override: 90%;
}
```

### INP < 200ms — zero JS bloqueante

INP mede o tempo de resposta à primeira interação do usuário. A receita é simples: nenhum
script no caminho crítico de renderização.

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

Embeds de vídeo (YouTube, Vimeo): use facade (poster image estático + load on click).
O iframe real carrega só quando o usuário interage, poupando ~500KB de JS de terceiros.

---

## Imagens: `<picture>` com AVIF + WebP

AVIF entrega 40–50% menos bytes que JPEG equivalente. Sempre ofereça fallback para
browsers mais antigos via `<picture>`.

```html
<picture>
  <!-- AVIF: suporte ~90% dos browsers modernos -->
  <source
    type="image/avif"
    srcset="/img/produto-400.avif 400w, /img/produto-800.avif 800w, /img/produto-1200.avif 1200w"
    sizes="(max-width: 600px) 100vw, (max-width: 900px) 50vw, 800px">
  <!-- WebP: fallback para browsers sem AVIF -->
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
`alt` vazio sem aspas (`alt` ausente) é erro de acessibilidade — diferente de `alt=""`.

---

## Auditar uma página (Modo Execução)

Quando a URL ou o HTML-fonte for fornecido, siga esta ordem de verificação:

1. **Tags semânticas**: o conteúdo principal está em `<article>` ou `<main>`? Há `<div>`
   substituindo `<section>`, `<aside>`, `<nav>`? Liste cada ocorrência com o trecho do HTML.

2. **Hierarquia de headings**: há exatamente 1 `<h1>`? Algum nível foi pulado? Algum heading
   ultrapassa 68 caracteres? Extraia a árvore e mostre.

3. **LCP candidate**: qual elemento o browser elege como LCP? Há `<link rel="preload"
   fetchpriority="high">` para ele no `<head>`? O CSS crítico está inline? O texto do herói
   é server-side ou depende de JS?

4. **JS bloqueante**: há `<script src>` sem `defer`/`async` antes do `</body>`? Algum script
   de terceiro (analytics, chat, pixel) carrega no `<head>` sem estratégia de lazy load?

5. **Fontes**: estão self-hosted (woff2 local) ou chamando Google Fonts CDN? `font-display:
   swap` declarado? `size-adjust` configurado na fallback?

6. **Imagens**: todas têm `width` e `height`? LCP image usa AVIF? Imagens abaixo da dobra
   têm `loading="lazy"`? `alt` descritivo (informativas) ou `alt=""` (decorativas)?

7. **Landmarks e ARIA**: há skip link? Múltiplas `<nav>` com `aria-label` distintos?
   `aria-current="page"` no breadcrumb?

Para cada achado, cite o trecho exato, o impacto (LCP, CLS, INP, acessibilidade, semântica)
e a correção precisa.

---

## Validação: o que "aprovado" significa

| Ferramenta | Critério de aprovação |
|---|---|
| validator.w3.org | Zero erros (warnings aceitáveis se justificados) |
| Lighthouse (desktop e mobile) | 100 / 100 / 100 / 100 |
| axe DevTools | Zero violações de acessibilidade |
| CrUX (Search Console) | LCP < 2,5s · CLS < 0,1 · INP < 200ms em campo |
| PageSpeed Insights | LCP < 2,0s · CLS = 0 · INP < 200ms (lab) |

Lab (Lighthouse, PageSpeed) confirma a implementação; campo (CrUX) confirma que usuários
reais experimentam o resultado. Lab perfeito com campo ruim aponta throttling de rede,
latência de servidor ou third-party carregado tarde o suficiente para passar no lab mas
não no mundo real. Ambos precisam estar verdes.

Os limiares completos de performance, bundle e servidor estão em
`../seo/references/padroes-de-producao.md` §5.

---

## Entrega

**Modo Execução:** diagnóstico por seção (semântica → headings → LCP → CLS/INP → imagens →
acessibilidade), cada achado com evidência citada e correção precisa. Termine indicando qual
item tem maior impacto e deve ser resolvido primeiro.

**Modo Framework:** esqueleto HTML5 adaptado ao tipo de página informado, com anotações
explicando cada escolha. Inclua checklist de validação e o próximo passo concreto para
medir o resultado após a publicação.
