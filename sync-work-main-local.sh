#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: execute dentro de um repositório git."
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Erro: há mudanças não commitadas. Faça commit antes de sincronizar branches locais."
  exit 1
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"
current_commit="$(git rev-parse --short HEAD)"

if [[ "$current_branch" != "work" ]]; then
  echo "Aviso: branch atual é '$current_branch'. O ideal é executar no branch 'work'."
fi

required=(README.md index.html styles.css script.js publish-to-github.sh publish-to-github.ps1 publish-main-and-work.sh debug-github-sync.sh)
missing=0
for f in "${required[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "Erro: arquivo obrigatório ausente: $f"
    missing=1
  fi
done

if [[ $missing -ne 0 ]]; then
  exit 2
fi

git branch -f main HEAD

echo "Sincronização local concluída."
echo "work -> ${current_commit}"
echo "main -> $(git rev-parse --short main)"
