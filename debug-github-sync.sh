#!/usr/bin/env bash
set -euo pipefail

echo '=== ClassUp sync diagnostic ==='
echo "pwd: $(pwd)"

echo
echo '1) Branch atual'
git branch --show-current

echo
echo '2) Status resumido'
git status --short --branch

echo
echo '3) Últimos commits locais'
git log --oneline --decorate -n 5

echo
echo '4) Arquivos versionados'
git ls-files | sort

echo
echo '5) Remote origin'
if git remote get-url origin >/dev/null 2>&1; then
  git remote -v
  echo
  echo '6) Referências remotas (ls-remote --heads origin)'
  git ls-remote --heads origin || true
else
  echo 'origin NÃO configurado neste clone.'
  echo 'Configure com: git remote add origin <url-do-repositorio>'
fi

echo
echo '7) Verificação de arquivos mínimos esperados'
missing=0
for f in README.md index.html styles.css script.js publish-to-github.sh publish-to-github.ps1 publish-main-and-work.sh; do
  if [[ -f "$f" ]]; then
    echo "[OK] $f"
  else
    echo "[MISSING] $f"
    missing=1
  fi
done

if [[ $missing -eq 1 ]]; then
  echo
  echo 'Erro: faltam arquivos obrigatórios neste clone.'
  exit 2
fi

echo
echo 'Diagnóstico concluído.'
