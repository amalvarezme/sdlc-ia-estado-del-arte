#!/usr/bin/env bash
# Crea el repositorio independiente, sube la aplicación y configura GitHub Pages.
# Requiere GitHub CLI autenticado con permisos de repositorio y Pages.
set -euo pipefail
OWNER="amalvarezme"
REPO="sdlc-ia-estado-del-arte"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: Instala GitHub CLI (https://cli.github.com/) y ejecuta gh auth login." >&2
  exit 1
fi
if ! gh auth status >/dev/null 2>&1; then
  echo "ERROR: Autentica GitHub CLI con gh auth login." >&2
  exit 1
fi
ACTOR="$(gh api user --jq .login)"
if [[ "$ACTOR" != "$OWNER" ]]; then
  echo "ERROR: la cuenta conectada es '$ACTOR' y el destino solicitado es '$OWNER'." >&2
  exit 1
fi
if [[ ! -d .git ]]; then
  git init -b main
fi
git branch -M main
git add .
if ! git diff --cached --quiet; then
  git -c user.name="${GIT_AUTHOR_NAME:-$ACTOR}" -c user.email="${GIT_AUTHOR_EMAIL:-${ACTOR}@users.noreply.github.com}" commit -m "feat: publicar estudio interactivo del SDLC con IA y Gentle-AI"
fi
if gh repo view "$OWNER/$REPO" >/dev/null 2>&1; then
  echo "El repositorio ya existe: https://github.com/$OWNER/$REPO"
else
  echo "Creando repositorio público independiente…"
  gh repo create "$OWNER/$REPO" --public --description "Estudio interactivo de ingeniería de software con IA, SDD, ODD, TDD y QA"
fi
if git remote get-url origin >/dev/null 2>&1; then
  ACTUAL="$(git remote get-url origin)"
  if [[ "$ACTUAL" != "https://github.com/$OWNER/$REPO.git" && "$ACTUAL" != "git@github.com:$OWNER/$REPO.git" ]]; then
    echo "ERROR: el remote origin apunta a '$ACTUAL'. No se sobrescribirá automáticamente." >&2
    exit 1
  fi
else
  git remote add origin "https://github.com/$OWNER/$REPO.git"
fi
git push --set-upstream origin main
if gh api "repos/$OWNER/$REPO/pages" >/dev/null 2>&1; then
  echo "GitHub Pages ya está configurado."
else
  echo "Configurando Pages con GitHub Actions…"
  gh api --method POST "repos/$OWNER/$REPO/pages" -f build_type=workflow >/dev/null || {
    echo "Advertencia: Pages requiere configuración manual: Settings > Pages > GitHub Actions." >&2
  }
fi
echo "Repositorio: https://github.com/$OWNER/$REPO"
echo "Workflow: https://github.com/$OWNER/$REPO/actions"
echo "Página prevista (tras despliegue): https://$OWNER.github.io/$REPO/"
