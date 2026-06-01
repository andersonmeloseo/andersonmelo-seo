#!/usr/bin/env bash
set -euo pipefail

# ════════════════════════════════════════════════════════════════
#  andersonmelo-seo — instalador manual
#  Use quando o comando nativo /plugin NÃO estiver disponível no seu
#  ambiente. Caminho recomendado (se você tem /plugin):
#     /plugin marketplace add andersonmeloseo/andersonmelo-seo
#     /plugin install andersonmelo-seo@andersonmelo-seo
#
#  Este script copia TODAS as skills para ~/.claude/skills/ e os
#  agents para ~/.claude/agents/ — locais que o Claude Code lê
#  nativamente (instala o que existir no repo; nunca fica desatualizado).
# ════════════════════════════════════════════════════════════════

REPO_URL="https://github.com/andersonmeloseo/andersonmelo-seo"
REPO_TAG="${ANDERSONMELO_SEO_TAG:-main}"

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

  # Copia TODAS as skills do repo (dinâmico — sem lista fixa que envelhece)
  echo "→ Instalando skills..."
  for skill_dir in "${SRC}/skills"/*/; do
    [ -d "${skill_dir}" ] || continue
    s="$(basename "${skill_dir}")"
    if [ -d "${SKILL_ROOT}/${s}" ]; then
      echo "  ⚠  '${s}' já existe em ${SKILL_ROOT} — será sobrescrita (verifique conflito com outro plugin de SEO)."
    fi
    rm -rf "${SKILL_ROOT}/${s}"
    cp -r "${SRC}/skills/${s}" "${SKILL_ROOT}/${s}"
    echo "  ✓ ${s}"
  done

  # Copia todos os agents (se houver)
  if compgen -G "${SRC}/agents/*.md" >/dev/null 2>&1; then
    echo "→ Instalando agents..."
    for a in "${SRC}/agents/"*.md; do
      cp "${a}" "${AGENT_ROOT}/" && echo "  ✓ $(basename "${a}")"
    done
  fi

  echo ""
  echo "✓ andersonmelo-seo instalado."
  echo "  Reinicie o Claude Code (ou abra uma nova sessão) e teste:"
  echo "     /seo auditoria https://exemplo.com"
  echo "  Desinstalar: bash uninstall.sh"
}

main "$@"
