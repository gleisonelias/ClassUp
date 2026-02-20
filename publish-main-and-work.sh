#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Uso: $0 <url-do-repositorio-github>"
  echo "Exemplo: $0 https://github.com/seu-usuario/ClassUp.git"
  exit 1
fi

REPO_URL="$1"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: execute dentro de um repositório git."
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Erro: há mudanças não commitadas. Faça commit antes de publicar."
  exit 1
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "${REPO_URL}"
else
  git remote add origin "${REPO_URL}"
fi

echo "Publicando branch local '${CURRENT_BRANCH}' em 'origin/main'..."
git push -u origin "${CURRENT_BRANCH}:main"

echo "Publicando branch local '${CURRENT_BRANCH}' em 'origin/work'..."
git push -u origin "${CURRENT_BRANCH}:work"

echo "Concluído: mesmo conteúdo publicado em main e work."
