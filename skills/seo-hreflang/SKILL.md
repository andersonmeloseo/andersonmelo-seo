---
name: seo-hreflang
description: Auditoria e geração de hreflang / SEO internacional — multi-idioma e multi-região. Use quando o usuário pedir "hreflang", "SEO internacional", "site multi-idioma", "multi-região", "x-default", "versão em inglês/espanhol", "tags de idioma", "i18n", "por que o Google mostra a página errada por país", "return tags" ou "traduções e SEO". Valida bidirecionalidade, códigos de idioma/região e gera o conjunto correto de hreflang.
user-invokable: true
argument-hint: "[url]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# seo-hreflang — servir a versão certa para cada idioma e país

`hreflang` resolve um problema específico: quando o **mesmo conteúdo** existe em mais de um
idioma ou região, ele diz ao Google qual versão servir para qual usuário. Não é fator de
ranking — é um sinal de segmentação. Mal implementado, ele se anula sozinho (e silenciosamente).

**Antes de tudo, confirme que hreflang é necessário.** Site em um único idioma e uma única
região **não precisa** de hreflang — adicioná-lo só cria superfície de erro. Hreflang serve
para: o mesmo conteúdo em idiomas diferentes (pt/en/es), ou o mesmo idioma em regiões
diferentes (pt-BR vs pt-PT, en-US vs en-GB). Se as versões têm **conteúdo diferente** (não
traduções), o problema é arquitetura, não hreflang.

## Declare o modo

- **Modo Execução** — URL acessível: extraia os hreflang existentes (no `<head>`, no sitemap
  ou no header HTTP) e valide. Cite o que encontrou.
- **Modo Framework** — sem acesso: gere o conjunto de hreflang correto para os locales que o
  usuário declarar, e explique cada regra.

## Anatomia correta

```html
<link rel="alternate" hreflang="pt-br" href="https://exemplo.com/br/" />
<link rel="alternate" hreflang="pt-pt" href="https://exemplo.com/pt/" />
<link rel="alternate" hreflang="en"    href="https://exemplo.com/en/" />
<link rel="alternate" hreflang="x-default" href="https://exemplo.com/" />
```

- **Idioma:** ISO 639-1 (`pt`, `en`, `es`) — obrigatório.
- **Região (opcional):** ISO 3166-1 Alpha-2 (`BR`, `PT`, `US`, `GB`). Formato `idioma` ou
  `idioma-REGIÃO`. Convenção: idioma minúsculo, região maiúscula (o Google é case-insensitive,
  mas mantenha a convenção).
- **`x-default`:** a versão de fallback (seletor de idioma ou versão padrão) para usuários que
  não casam com nenhum locale. Quase sempre faltando — inclua.
- **Um método só:** `<head>`, sitemap XML **ou** header HTTP. Não misture — duplicar em dois
  métodos gera conflito.

## Os erros que anulam o hreflang (em ordem de frequência)

1. **Return tags ausentes (bidirecionalidade).** Se a página A aponta para B, B **precisa**
   apontar de volta para A. Sem o par de retorno, o Google ignora o conjunto inteiro. É o erro
   nº 1 e o mais silencioso.
2. **Falta a tag auto-referente.** Cada página deve incluir um hreflang apontando para ela
   mesma.
3. **Códigos inválidos.** `en-UK` (não existe — é `en-GB`), inventar região com código de
   idioma, ou usar locale do CMS em vez de ISO. Código inválido = linha ignorada.
4. **Apontar para URL não-canônica, redirecionada ou 404.** hreflang deve apontar para a URL
   canônica e indexável de cada versão. hreflang + `canonical` apontando para destinos
   diferentes na mesma página se contradizem.
5. **`x-default` ausente.**
6. **Misturar métodos** (head + sitemap) com conjuntos divergentes.

## Validação (Modo Execução)

Para cada página do conjunto: o hreflang é auto-referente? Todos os pares têm return tag? Os
códigos são ISO válidos? Os destinos respondem 200 e são canônicos? Há `x-default`? O método é
único? Reporte cada quebra com a URL e a linha exata — hreflang quebra por par, não por site.

## Geração (Modo Framework)

Peça ao usuário os locales e o padrão de URL (subpasta `/br/`, subdomínio `br.`, ou ccTLD).
Gere o bloco completo, **idêntico em todas as páginas do grupo** (cada uma lista todas as
versões, incluindo a si mesma e o `x-default`). Para muitos locales ou muitas páginas, prefira
o **sitemap XML** com `xhtml:link` — é mais sustentável que manter no `<head>` em escala (cruze
com `seo-programmatic`).

## Saída

Entregue: o diagnóstico (pares quebrados, códigos inválidos, x-default ausente) classificado
por `evidência → impacto → esforço → prioridade`, ou o conjunto de hreflang gerado. Lembre que
hreflang **não** melhora ranking — corrige *qual versão* rankeia em cada país/idioma. Termine
com o próximo passo concreto (ex.: "valide os return tags com o relatório de Internacional do
Search Console").
