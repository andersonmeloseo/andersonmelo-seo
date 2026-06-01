#!/usr/bin/env bash
set -euo pipefail

# ════════════════════════════════════════════════════════════════
#  andersonmelo-seo — desinstalador
#  Remove APENAS as skills e agents deste plugin (deriva a lista do
#  próprio repo — rode a partir de um clone). Não toca em outros plugins,
#  exceto nos nomes compartilhados (ex.: seo, seo-geo, seo-schema,
#  seo-programmatic também existem no claude-seo).
#  Se você instalou via /plugin, prefira:
#     /plugin uninstall andersonmelo-seo@andersonmelo-seo
# ════════════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_ROOT="${HOME}/.claude/skills"
AGENT_ROOT="${HOME}/.claude/agents"

echo "════════════════════════════════════════"
echo "  andersonmelo-seo — desinstalador"
echo "════════════════════════════════════════"
echo "⚠  Remove as skills/agents deste plugin de ${SKILL_ROOT}."
echo "   Nomes como seo/seo-geo/seo-schema/seo-programmatic também são usados pelo"
echo "   claude-seo — se você usa os dois via install manual, reinstale o claude-seo depois."
echo ""
read -r -p "Continuar? [s/N] " ans
case "${ans}" in
  s|S|sim|y|Y) ;;
  *) echo "Cancelado."; exit 0 ;;
esac

if [ ! -d "${SCRIPT_DIR}/skills" ]; then
  echo "✗ Rode a partir de um clone do repositório (não achei ./skills)."
  exit 1
fi

for skill_dir in "${SCRIPT_DIR}/skills"/*/; do
  [ -d "${skill_dir}" ] || continue
  s="$(basename "${skill_dir}")"
  if [ -d "${SKILL_ROOT}/${s}" ]; then
    rm -rf "${SKILL_ROOT}/${s}"
    echo "  ✓ removida: ${s}"
  fi
done

if compgen -G "${SCRIPT_DIR}/agents/*.md" >/dev/null 2>&1; then
  for a in "${SCRIPT_DIR}/agents/"*.md; do
    n="$(basename "${a}")"
    if [ -f "${AGENT_ROOT}/${n}" ]; then
      rm -f "${AGENT_ROOT}/${n}"
      echo "  ✓ removido agent: ${n}"
    fi
  done
fi

echo ""
echo "✓ andersonmelo-seo desinstalado."
