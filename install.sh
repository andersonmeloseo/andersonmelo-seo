#!/usr/bin/env bash
set -euo pipefail

# ════════════════════════════════════════════════════════════════
#  andersonmelo-seo — instalador manual
#  Use SOMENTE quando o comando nativo /plugin não estiver disponível
#  no seu ambiente. O caminho recomendado é:
#     /plugin marketplace add andersonmeloseo/andersonmelo-seo
#     /plugin install andersonmelo-seo@andersonmelo-seo
#  (via /plugin as skills ficam isoladas por namespace e não colidem
#   com outros plugins de SEO instalados.)
#
#  Este script copia as skills para ~/.claude/skills/ e os agents para
#  ~/.claude/agents/ — locais que o Claude Code lê nativamente.
# ════════════════════════════════════════════════════════════════

REPO_URL="https://github.com/andersonmeloseo/andersonmelo-seo"
REPO_TAG="${ANDERSONMELO_SEO_TAG:-main}"

# Skills deste plugin (lista explícita — uninstall remove exatamente estas)
SKILLS=(seo seo-auditoria seo-topical seo-on-page seo-geo seo-programmatic seo-schema seo-semantic-html seo-local-rank-and-rent)

main() {
  SKILL_ROOT="${HOME}/.claude/skills"
  AGENT_ROOT="${HOME}/.claude/agents"
  mkdir -p "${SKILL_ROOT}" "${AGENT_ROOT}"

  echo "════════════════════════════════════════"
  echo "  andersonmelo-seo — instalador"
  echo "════════════════════════════════════════"

  # Origem: clone local (rodando de dentro do repo) ou clone fresco do GitHub
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  CLEANUP=""
  if [ -d "${SCRIPT_DIR}/skills/seo" ]; then
    SRC="${SCRIPT_DIR}"
    echo "→ Instalando a partir do clone local: ${SRC}"
  else
    command -v git >/dev/null 2>&1 || { echo "✗ git é necessário."; exit 1; }
    TMP="$(mktemp -d)"; CLEANUP="${TMP}"; trap '[ -n "${CLEANUP}" ] && rm -rf "${CLEANUP}"' EXIT
    echo "↓ Baixando andersonmelo-seo (${REPO_TAG})..."
    git clone --depth 1 --branch "${REPO_TAG}" "${REPO_URL}" "${TMP}/repo" 2>/dev/null
    SRC="${TMP}/repo"
  fi

  # Copia as skills (avisa sobre sobrescrita — outro plugin de SEO pode usar o mesmo nome)
  echo "→ Instalando skills..."
  for s in "${SKILLS[@]}"; do
    if [ -d "${SRC}/skills/${s}" ]; then
      if [ -d "${SKILL_ROOT}/${s}" ]; then
        echo "  ⚠  '${s}' já existe em ${SKILL_ROOT} — será sobrescrita (verifique conflito com outro plugin)."
      fi
      rm -rf "${SKILL_ROOT}/${s}"
      cp -r "${SRC}/skills/${s}" "${SKILL_ROOT}/${s}"
      echo "  ✓ ${s}"
    fi
  done

  # Copia agents (se houver)
  if compgen -G "${SRC}/agents/*.md" >/dev/null 2>&1; then
    echo "→ Instalando agents..."
    cp -r "${SRC}/agents/"*.md "${AGENT_ROOT}/" 2>/dev/null || true
  fi

  echo ""
  echo "✓ andersonmelo-seo instalado."
  echo "  Uso:  /seo auditoria https://exemplo.com"
  echo "        /seo topical \"sua entidade central\""
  echo "  Desinstalar:  bash uninstall.sh"
}

main "$@"
