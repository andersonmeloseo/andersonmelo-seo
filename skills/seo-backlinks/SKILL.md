---
name: seo-backlinks
description: Análise de perfil de backlinks e autoridade — referring domains, distribuição de anchor text, links tóxicos, link gap vs concorrente e link earning. Use quando o usuário pedir "analisar backlinks", "perfil de links", "referring domains", "anchor text", "link tóxico", "disavow", "link gap", "autoridade de domínio", "DA/DR", "de onde vêm meus links", "links do concorrente" ou "estratégia de link building". Funciona com free-tier (Bing Webmaster, Common Crawl, GSC) ou com dados pagos (Ahrefs/Semrush/Moz) quando fornecidos.
user-invokable: true
argument-hint: "[url|domínio]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# seo-backlinks — autoridade off-page sem inventar número

Backlinks ainda são um dos sinais mais fortes do Google, mas é a dimensão onde mais se
alucina métrica. DA e DR são **scores proprietários de Moz e Ahrefs** — não são números do
Google e não existem sem a ferramenta. Esta skill analisa autoridade a partir de dado real,
e quando o dado falta, entrega o método — nunca um número inventado.

## Declare o modo

- **Modo Execução** — há export/print de Ahrefs, Semrush, Moz, Bing Webmaster Tools ou do
  relatório de Links do Search Console (apenas para o próprio site). Analise de verdade, cite
  os números fornecidos.
- **Modo Framework** — sem dados de ferramenta. Entregue o que coletar, onde (incluindo
  fontes gratuitas) e o que cada achado revelaria. Não estime DA/DR, contagem de referring
  domains ou "toxicidade" sem fonte.

## De onde tirar dado real (inclusive de graça)

A maioria das pessoas acha que precisa de Ahrefs para olhar links. Não precisa para começar:

- **Google Search Console → Links** — o perfil de links do *seu próprio* site direto da fonte
  (top linking sites, top linked pages, top anchor text). Grátis e autoritativo.
- **Bing Webmaster Tools → Backlinks** — perfil de links de qualquer domínio que você
  verifique, e dados de inbound links. Grátis.
- **Common Crawl** — corpus aberto da web; dá para extrair links em nível de domínio sem API
  paga (requer processamento, mas é gratuito e imparcial).
- **Pago (quando fornecido):** Ahrefs, Semrush, Moz, Majestic — referring domains, DR/DA,
  Trust Flow/Citation Flow, histórico de links. Use os números deles, atribuindo a fonte.

Sem nenhum desses, você está em Modo Framework: descreva o que cada fonte mostraria.

## O que analisar

**Referring domains, não backlinks.** 1.000 links de 1 domínio valem menos que 50 links de
50 domínios relevantes. O número que importa é a quantidade e a qualidade de *domínios*
distintos que linkam — e a relevância temática deles com a sua entidade.

**Distribuição de anchor text.** Um perfil natural é dominado por âncoras de marca e URL nua,
com poucas âncoras de match exato de keyword. Excesso de anchor com keyword exato é sinal de
manipulação (risco de Penguin/spam). Avalie a proporção: marca / URL / genérico ("saiba
mais") / keyword exato / parcial. Concentração alta em keyword exato é achado de alto risco.

**Relevância e autoridade da fonte.** Um link de um site do mesmo nicho com tráfego real vale
muito mais que um diretório genérico. Avalie: o domínio que linka é tematicamente relacionado?
Tem tráfego orgânico próprio? É um link editorial (dentro do conteúdo) ou de footer/sidebar/
boilerplate?

**Velocidade de aquisição.** Crescimento natural é gradual. Picos súbitos de centenas de links
em dias — sem um motivo (viral, PR, menção grande) — são padrão de link comprado/PBN e atraem
escrutínio.

**Links tóxicos e disavow — com cautela.** O Google em 2026 ignora a maior parte do spam de
links automaticamente; a maioria dos sites **não precisa** de disavow. Recomende disavow apenas
quando há (a) ação manual por links não naturais no GSC, ou (b) histórico conhecido de
link building black-hat que você está limpando. Disavow preventivo "por garantia" pode remover
links bons por engano — é mais arriscado que o problema que resolve. Diga isso.

**Link gap vs concorrentes.** Os domínios que linkam para 2-3 concorrentes mas não para você
são a lista de prospecção mais valiosa — são fontes que já linkam neste nicho. Em Modo
Execução com dados de ferramenta, monte essa lista; em Framework, descreva como obtê-la.

## Earning de links (não "construção" manipulativa)

A skill não ensina a comprar ou trocar links — isso é risco, não estratégia. O que sustenta
autoridade no longo prazo:

- **Ativos linkáveis (linkable assets):** dado primário, pesquisa original, calculadora,
  ferramenta, guia definitivo — coisas que pessoas linkam porque agregam valor. Cruze com a
  skill `seo-on-page`/`seo-topical` para Information Gain.
- **Digital PR:** ser fonte citável para jornalistas e sites do nicho (dado, opinião de
  especialista nomeado — reforça também E-E-A-T).
- **Consolidação de entidade:** menções de marca (mesmo sem link), `sameAs` e perfis reais
  constroem o nó da entidade no Knowledge Graph — cruze com `seo-schema`.

## Saída

Entregue: avaliação do perfil (referring domains, saúde do anchor text, relevância,
velocidade), os riscos classificados (evidência → impacto → esforço → prioridade), a lista de
link gap/prospecção quando houver dado, e o que ferramentas pagas adicionariam. Termine com um
próximo passo concreto — geralmente "conecte o GSC/Bing Webmaster e exporte o relatório de
links" quando estiver em Modo Framework. Nunca um número de autoridade inventado.
