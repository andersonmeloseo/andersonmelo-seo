#!/usr/bin/env python3
"""Valida a integridade do plugin andersonmelo-seo.

Roda local:  python3 scripts/validate.py
CI:          .github/workflows/validate.yml

Checa: manifests parseiam, cada skill tem o frontmatter exigido, e não há
template do spec vazado na description (regressão conhecida). Sem dependências
externas — só a stdlib.
"""
import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
errors = []


def check(cond, msg):
    if not cond:
        errors.append(msg)


# 1) Manifests parseiam como JSON
for mf in [".claude-plugin/marketplace.json", ".claude-plugin/plugin.json"]:
    path = os.path.join(ROOT, mf)
    try:
        json.load(open(path, encoding="utf-8"))
    except Exception as exc:  # noqa: BLE001
        errors.append(f"{mf}: JSON inválido — {exc}")

# 2) Frontmatter de cada skill
skills_dir = os.path.join(ROOT, "skills")
for name in sorted(os.listdir(skills_dir)):
    skill = os.path.join(skills_dir, name, "SKILL.md")
    if not os.path.isfile(skill):
        continue
    text = open(skill, encoding="utf-8").read()
    fm_match = re.match(r"^---\n(.*?)\n---", text, re.S)
    check(bool(fm_match), f"{name}: frontmatter ausente")
    fm = fm_match.group(1) if fm_match else ""

    nm = re.search(r"^name:\s*(.+)$", fm, re.M)
    check(bool(nm) and nm.group(1).strip() == name,
          f"{name}: campo 'name' ausente ou diferente do diretório")
    check("user-invokable: true" in fm, f"{name}: falta 'user-invokable: true'")
    check("license: MIT" in fm, f"{name}: falta 'license: MIT'")
    check("Anderson Melo" in fm, f"{name}: falta autoria (Anderson Melo)")

    desc = re.search(r"^description:\s*(.+)$", fm, re.M)
    check(bool(desc), f"{name}: campo 'description' ausente")
    if desc:
        leaked = "<PT-BR" in desc.group(1) or "pushy" in desc.group(1)
        check(not leaked,
              f"{name}: description contém template do spec não resolvido (<PT-BR/pushy)")

# 3) Frontmatter dos agents (audit subagents), se houver
agents_dir = os.path.join(ROOT, "agents")
if os.path.isdir(agents_dir):
    for fn in sorted(os.listdir(agents_dir)):
        if not fn.endswith(".md"):
            continue
        text = open(os.path.join(agents_dir, fn), encoding="utf-8").read()
        fm_match = re.match(r"^---\n(.*?)\n---", text, re.S)
        check(bool(fm_match), f"agents/{fn}: frontmatter ausente")
        fm = fm_match.group(1) if fm_match else ""
        check("name:" in fm, f"agents/{fn}: falta 'name'")
        check("description:" in fm, f"agents/{fn}: falta 'description'")

# 4) Consistência de contagem e roteamento (impede deriva de "N sub-skills")
sub_skills = [d for d in sorted(os.listdir(skills_dir))
              if d != "seo" and os.path.isfile(os.path.join(skills_dir, d, "SKILL.md"))]
n_sub = len(sub_skills)

for mf in [".claude-plugin/plugin.json", ".claude-plugin/marketplace.json"]:
    txt = open(os.path.join(ROOT, mf), encoding="utf-8").read()
    for m in re.finditer(r"(\d+)\s+sub-skills", txt):
        check(int(m.group(1)) == n_sub,
              f"{mf}: declara '{m.group(1)} sub-skills' mas existem {n_sub}")

orch = open(os.path.join(skills_dir, "seo", "SKILL.md"), encoding="utf-8").read()
for s in sub_skills:
    check(s in orch, f"orquestrador (seo): sub-skill '{s}' não aparece no roteamento")
m = re.search(r"Roteador de (\d+) sub-skills", orch)
check(bool(m) and int(m.group(1)) == n_sub,
      f"orquestrador: 'Roteador de N sub-skills' != {n_sub}")

if errors:
    print("✗ Validação falhou:")
    for err in errors:
        print("  -", err)
    sys.exit(1)

print("✓ Plugin válido: manifests OK, frontmatter OK, sem regressões de template.")
