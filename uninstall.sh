#!/usr/bin/env bash
set -euo pipefail

# ════════════════════════════════════════════════════════════════
#  andersonmelo-seo — desinstalador
#  Remove APENAS as skills deste plugin (lista explícita), para não
#  afetar outros plugins de SEO que compartilhem nomes (ex.: seo-geo,
#  seo-schema, seo-programmatic também existem no claude-seo).
#  Se você instalou via /plugin, prefira:
#     /plugin uninstall andersonmelo-seo@andersonmelo-seo
# ════════════════════════════════════════════════════════════════

SKILLS=(seo seo-auditoria seo-topical seo-on-page seo-geo seo-programmatic seo-schema seo-semantic-html seo-local-rank-and-rent)

SKILL_ROOT="${HOME}/.claude/skills"

echo "════════════════════════════════════════"
echo "  andersonmelo-seo — desinstalador"
echo "════════════════════════════════════════"
echo "⚠  Isto remove as skills listadas de ${SKILL_ROOT}."
echo "   Nomes como seo-geo/seo-schema/seo-programmatic também são usados"
echo "   pelo claude-seo — se você usa os dois via install manual, reinstale o claude-seo depois."
echo ""
read -r -p "Continuar? [s/N] " ans
case "${ans}" in
  s|S|sim|y|Y) ;;
  *) echo "Cancelado."; exit 0 ;;
esac

for s in "${SKILLS[@]}"; do
  if [ -d "${SKILL_ROOT}/${s}" ]; then
    rm -rf "${SKILL_ROOT}/${s}"
    echo "  ✓ removida: ${s}"
  fi
done

echo ""
echo "✓ andersonmelo-seo desinstalado."
