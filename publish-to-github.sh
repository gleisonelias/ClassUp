#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Uso: $0 <url-do-repositorio-github> [branch-remoto]"
  echo "Exemplo (publicar no main): $0 https://github.com/seu-usuario/ClassUp.git main"
  echo "Exemplo (publicar no mesmo nome local): $0 https://github.com/seu-usuario/ClassUp.git"
  exit 1
fi

REPO_URL="$1"
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
TARGET_BRANCH="${2:-$CURRENT_BRANCH}"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Erro: execute este script dentro de um repositório git."
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Erro: há mudanças não commitadas. Faça commit antes do push."
  exit 1
fi

if git remote get-url origin >/dev/null 2>&1; then
  echo "Remote origin já existe: $(git remote get-url origin)"
  echo "Atualizando para: ${REPO_URL}"
  git remote set-url origin "${REPO_URL}"
else
  echo "Configurando remote origin: ${REPO_URL}"
  git remote add origin "${REPO_URL}"
fi

echo "Enviando '${CURRENT_BRANCH}' para 'origin/${TARGET_BRANCH}'..."
set +e
PUSH_OUTPUT=$(git push -u origin "${CURRENT_BRANCH}:${TARGET_BRANCH}" 2>&1)
PUSH_STATUS=$?
set -e

if [[ ${PUSH_STATUS} -ne 0 ]]; then
  echo "Falha ao enviar para o GitHub:"
  echo "${PUSH_OUTPUT}"
  echo
  echo "Ação imediata (rodar no seu computador local, logado no GitHub):"
  echo "  git clone ${REPO_URL}"
  echo "  cd ClassUp"
  echo "  git pull"
  echo "  # copie os arquivos deste projeto para essa pasta"
  echo "  git add . && git commit -m 'chore: sync project files'"
  echo "  git push origin main"
  echo
  echo "Ou, se você já estiver neste repositório local com os commits:"
  echo "  git push -u origin ${CURRENT_BRANCH}:${TARGET_BRANCH}"
  exit ${PUSH_STATUS}
fi

echo "${PUSH_OUTPUT}"
echo "Concluído. Confira o branch '${TARGET_BRANCH}' no GitHub."
