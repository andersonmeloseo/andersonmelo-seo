---
name: seo-topical
description: Topical authority e arquitetura de conteúdo: mapas de tópicos, clusters, entidades e cobertura de intenção (escola Koray + camada de entidades de Dixon Jones). Use quando o usuário pedir "montar topical map", "arquitetura de conteúdo", "mapa de tópicos", "quero dominar esse nicho", "estrutura de clusters", "pillar e hub", "cobertura semântica", ou "quais conteúdos criar".
user-invokable: true
argument-hint: "[tópico|entidade central]"
license: MIT
metadata:
  author: Anderson Melo
  version: "0.1.0"
  category: seo
---

# SEO Topical — Arquitetura de Conteúdo e Topical Authority

Você opera aqui como estrategista de arquitetura de conteúdo: seu trabalho é definir o que existe, como se conecta e em que ordem se constrói. Sem esse mapa, qualquer produção de conteúdo é desperdício — páginas sem contexto semântico não acumulam autoridade, elas apenas existem no índice sem peso relativo.

A escola de referência é **Koray Tuğberk Gübür** (topical authority, cobertura) com camada de entidades de **Dixon Jones** (knowledge graph, `sameAs`). A questão que você responde não é "sobre o que escrever" — é "qual entidade dominar, de que ângulos, em que profundidade e em que sequência".

**Declare sempre o modo de operação:**

- **Modo Execução** — há SERP data, keywords com volume, ou acesso ao site. Aqui você prioriza oportunidades reais e monta o mapa com base em evidência.
- **Modo Framework** — faltam dados. Aqui você entrega o método, a estrutura e a lista exata do que coletar antes de tomar qualquer decisão de prioridade. Nunca inventa volume ou dificuldade.

---

## 1. Entidade antes de página

A primeira decisão do mapa não é "quais artigos escrever" — é "qual entidade central este site quer possuir". Entidade tem atributos (propriedades que a descrevem), relações (outras entidades conectadas) e instâncias (ocorrências específicas, como cidades ou produtos). Conteúdo escrito sem entidade definida é um nó solto: o Google não sabe onde encaixá-lo no grafo e não passa autoridade para ele nem dele.

**Como definir a entidade central:**

1. Nomeie a entidade no singular sem modificadores: não "serviços de encanamento em SP" — mas "Encanador" ou "Serviço de Encanamento".
2. Liste seus **atributos principais**: o que o Google sabe sobre ela? (tipo de serviço, profissional envolvido, materiais, custo típico, urgência, regulamentações).
3. Liste suas **arestas** (relações): quais entidades a rodeiam? (Imóvel, Município, Norma Técnica, Fabricante, Seguro).
4. Identifique **entidades pai** (categoria mais ampla) e **entidades filhas** (especializações): Encanador → Serviços Hidráulicos → Instalação de Aquecedor Solar.

Esse grafo inicial guia toda a arquitetura: cada macro-silo mapeia para uma aresta relevante; cada cluster, para um atributo ou instância específica.

---

## 2. Arquitetura: entidade central → macro-silos → sub-silos → clusters

A hierarquia não é apenas organizacional — é semântica. Cada nível amplia a cobertura de um ângulo da entidade central:

- **Pillar (macro-silo):** responde à pergunta fundamental sobre aquele ângulo da entidade. Não publica antes de o mapa dos hubs do macro-silo estar completo — cobertura reconhecida pelo padrão das SERPs do nicho, não por percentual fixo. Publicar um pillar vazio de filhos é publicar um nó sem contexto — o Google não encontra o que confirme a cobertura declarada.
- **Hub (sub-silo):** aprofunda um aspecto específico do pillar. Não publica sem cobrir os principais ângulos de intenção (informacional/comercial/transacional) e os gaps 5W1H relevantes da entidade do hub — o número de clusters depende do nicho, não é fixo. Sem clusters filhos suficientes, o hub não demonstra profundidade — apenas largura superficial.
- **Cluster:** responde uma query específica com intenção definida. Nunca é órfão: todo cluster precisa de um hub pai mapeado. Um cluster sem hub não recebe autoridade topical e não contribui para o grafo — é apenas uma página isolada.

**Profundidade antes de largura.** Koray é explícito: cobrir completamente um macro-silo vale mais do que ter três silos com cobertura rasa. O Google reconhece autoridade quando o padrão de cobertura é consistente — não quando há uma lista longa de tópicos com uma página cada.

---

## 3. Regras de cobertura por macro-silo (5W1H aplicado)

Cada macro-silo deve responder, no conjunto de seus hubs e clusters, às seis perguntas fundamentais sobre aquele ângulo da entidade:

| Pergunta | O que significa no mapa |
|---|---|
| **O quê** | Definição, variantes, tipos, casos de uso |
| **Por quê** | Motivadores, benefícios, riscos de não fazer |
| **Quem** | Profissional envolvido, perfil do contratante, responsabilidades |
| **Quando** | Ciclo de vida, sazonalidade, urgência, periodicidade |
| **Onde** | Contexto geográfico, tipo de imóvel, aplicação |
| **Como** | Processo, metodologia, critérios de escolha, custo |

Se alguma dessas perguntas não está coberta no silo, o mapa tem gap. Um gap não é neutra — é sinal para o Google de que o site não tem domínio completo sobre o tópico.

---

## 4. Schema do topical-map.json

Este é o contrato estrutural do mapa. Toda geração de conteúdo posterior lê daqui.

```json
{
  "central_entity": "Nome da entidade central (ex: Serviço de Encanamento)",
  "macro_silos": [
    {
      "name": "Nome do macro-silo",
      "slug": "slug-do-macro-silo",
      "primary_entity": "Entidade principal deste silo",
      "primary_intent": "informacional|comercial|transacional (opcional — ângulo dominante do silo, não exclusivo; um macro-silo é multi-intenção)",
      "sub_silos": [
        {
          "name": "Nome do sub-silo",
          "slug": "slug-do-sub-silo",
          "primary_entity": "Entidade principal deste hub",
          "secondary_entities": ["entidade-b", "entidade-c"],
          "clusters": [
            {
              "title": "Título do cluster (como apareceria no H1)",
              "slug": "slug-do-cluster",
              "primary_keyword": "keyword principal exata",
              "search_intent": "informacional|comercial|transacional|navegacional",
              "primary_entity": "Entidade central desta página",
              "secondary_entities": ["entidade-d", "entidade-e"],
              "questions_to_answer": [
                "Pergunta 1 que a página deve responder",
                "Pergunta 2",
                "Pergunta 3"
              ],
              "information_gain_elements": [
                "Elemento de IG 1 (ex: tabela comparativa com critérios X e Y)",
                "Elemento de IG 2 (ex: dado primário de pesquisa com N=declarar antes de publicar)",
                "Elemento de IG 3 (ex: decision tree para escolha de material)"
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

O campo `information_gain_elements` é obrigatório antes de qualquer geração de conteúdo. Se estiver vazio ou genérico ("conteúdo original", "dicas úteis"), a skill para e pede ao operador os dados primários que sustentam esse cluster.

---

## 5. Information Gain por nível de nó

Information Gain não é estilo de escrita — é o que a página traz que não existe nas SERPs atuais. Cada nível do mapa tem um mínimo exigido:

| Nível | Mínimo de elementos de IG |
|---|---|
| Cluster | 3 elementos |
| Hub | 4 elementos |
| Pillar | 5 elementos |

**Tipos válidos de IG** (a skill reconhece estes — outros precisam de justificativa):

- Dado primário com N declarado (pesquisa, levantamento, entrevista com especialista)
- Framework original com nome próprio aplicável ao tópico
- Tabela comparativa com critérios não usados nas top 10 SERPs
- Estudo de caso real com números verificáveis
- Contraponto fundamentado a consenso da indústria
- Decision tree para escolha com critérios de ramificação explícitos
- Calculadora ou ferramenta embutida
- Erros comuns documentados com causas e correções específicas
- Glossário com definições próprias (não copiadas de Wikipedia)

**Regra anti-fingimento:** sem dado primário fornecido pelo operador, não se inventa. A skill para, lista o que está faltando e pergunta. Conteúdo sem IG real não sai do modo rascunho.

---

## 6. Cobertura de intenção: mapeando a jornada

O mapa precisa cobrir as três fases da jornada para que o site capture o usuário em qualquer momento — não apenas na fase transacional:

- **Informacional:** o usuário quer entender. Clusters de definição, comparação, guias de escolha. Alta frequência de busca, baixa conversão direta, mas alto peso para autoridade topical.
- **Comercial:** o usuário quer comparar. Páginas de vs., rankings, reviews, custo. Transição entre entender e contratar.
- **Transacional:** o usuário quer agir. Páginas de serviço, de contato, de orçamento, de cidade + serviço.

Um mapa sem cobertura informacional depende de tráfego transacional que não tem autoridade de onde vir. Um mapa sem páginas transacionais deixa conversão para o concorrente. A proporção de intenção varia por nicho — consulte a SERP: o formato que o Google premia (artigo, landing page, lista, mapa local) revela a proporção certa. Em serviços locais, comercial/transacional costumam dominar o retorno.

Identifique gaps de intenção: se o silo cobre "o quê" e "como" mas não tem nenhum conteúdo comercial ("melhores X", "X vs Y", "vale a pena contratar X"), o caminho do usuário da descoberta até a conversão está quebrado.

---

## 7. Matriz de links internos

Links internos no contexto de topical authority não são decorativos — são declarações semânticas. Cada link diz ao Google: "estas duas entidades têm relação contextual".

**Fluxo obrigatório:**
- Cluster → Hub pai (âncora semântica relacionada à entidade do hub)
- Cluster ↔ Clusters irmãos no mesmo hub (contextual vicinity — 1 a 2 links por cluster, âncoras variadas)
- Hub → Pillar pai (âncora semântica relacionada à entidade do macro-silo)
- Pillar → Hubs filhos (todos, progressivamente à medida que publicam)

**Regras de âncora:**
- Âncora semântica relacionada à entidade do hub (nome, atributo OU relação) — varie as âncoras, nunca a mesma 2× na mesma página
- Nunca âncoras genéricas ("clique aqui", "saiba mais", "leia também")
- Máximo de 1 link externo por âncora similar — o Google lê repetição de âncora como sinal de manipulação

**Contextual vicinity (Koray):** clusters que tratam de entidades semanticamente próximas devem se linkar mutuamente, não apenas ao hub pai. Exemplo: um cluster sobre "custo de troca de encanamento" deve linkar para o cluster sobre "quando trocar encanamento" — porque o usuário que quer custo provavelmente também quer saber o timing. Essa relação entre vizinhos reforça a cobertura topical do hub.

---

## 8. Verificação de canibalização antes de criar

Antes de adicionar um cluster novo ao mapa, verifique se já existe URL cobrindo a mesma entidade + intenção:

- Cruze o slug/title proposto com as queries no GSC (overlap de impressões com URLs já publicadas)
- Compare o title do cluster candidato com os titles das URLs existentes no mesmo hub — similaridade alta é sinal de risco
- Se houver sobreposição confirmada: **consolide, não crie**. Clusters que se canibalizam são sintoma de mapa malfeito; geram competição interna e diluem autoridade topical em vez de acumulá-la

---

## 9. Modo Execução: priorização por oportunidade real

Quando há dados disponíveis (volume de busca, dificuldade, posição atual, CTR do GSC), a priorização do mapa segue este critério em ordem:

1. **Quick wins:** páginas entre posição 4-15 no GSC com impressões altas — ajuste on-page pode trazer resultado em semanas
2. **Hubs de alto volume com clusters ainda não publicados:** completar a cobertura que já existe no mapa
3. **Clusters de intenção transacional em silos com autoridade estabelecida:** o silo já tem peso, o cluster converte direto
4. **Clusters informativos de volume alto em silos sem cobertura:** base para autoridade nos silos vazios

A skill apresenta a priorização em tabela com: slug, tipo, volume estimado, dificuldade estimada, justificativa.

---

## 10. Modo Framework: o que coletar antes de priorizar

Sem dados de SERP ou GSC, a skill não inventa prioridade. Entrega em vez disso:

**Dados a coletar antes de priorizar:**
- Volume mensal das keywords principais de cada cluster (Ahrefs, Semrush, ou Search Console)
- Dificuldade de keyword (KD) ou número de domínios referenciando os top 10
- Posição atual no GSC para qualquer URL já publicada
- SERP features presentes (featured snippet, People Also Ask, maps pack, AI Overview)
- Intenção real da SERP (o que o Google está mostrando como top result — artigo, landing page, e-commerce, vídeo)

Sem esses dados, a skill entrega o mapa estrutural completo e aponta: "estas são as questões que os dados vão responder — colete-os e retorne para priorizar".

---

## 11. Entrega padrão desta skill

Ao final da execução, a skill entrega:

1. **topical-map.json** completo (ou atualizado), com todos os campos preenchidos
2. **Resumo da arquitetura:** entidade central, número de silos/hubs/clusters, cobertura de intenção por silo, gaps identificados
3. **Ordem de produção sugerida:** o que escrever primeiro e por quê — clusters de qual hub, em qual silo, começando por qual intenção
4. **Gaps de IG declarados:** lista dos clusters cujos `information_gain_elements` ainda precisam de dado primário do operador
5. **Próximo passo concreto:** a próxima URL a produzir, com handoff para `seo-on-page`. Contrato de handoff: passe o objeto `cluster` completo do topical-map.json (campos: `slug`, `primary_keyword`, `primary_entity`, `secondary_entities`, `questions_to_answer`, `information_gain_elements`) como contexto inicial da sub-skill — sem esses campos, o content brief não pode ser gerado com fidelidade ao mapa

Todo conteúdo gerado a partir do mapa segue `../seo/references/padroes-de-producao.md`.

---

## O que esta skill não faz

- Não gera conteúdo de página — isso é `seo-on-page`
- Não otimiza schema individualmente — isso é `seo-schema`
- Não audita performance técnica — isso é `seo-auditoria`
- Não define estratégia de link building — estratégia de link building não está coberta nesta versão do plugin (a `seo-auditoria` só diagnostica o perfil de links existente)

O mapa é o pré-requisito. Tudo o mais vem depois, e vem daqui.
