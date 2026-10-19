# Ingeniería de software en la era agéntica · 2026

Estudio interactivo en React sobre SDLC con IA, Prompt Engineering, Vibe Coding, agentes, Spec-Driven Development, TDD, QA y Gentle-AI (ODD + Engram + RDD).

## Estado del despliegue

**No publicado todavía.** La integración disponible no permite crear repositorios y devolvió `403 Resource not accessible by integration` al intentar escribir en un repositorio existente. El sitio está preparado para GitHub Pages. Se incluye `scripts/publicar-github.sh` para crearlo y desplegarlo desde una sesión de GitHub CLI autorizada.

## Arquitectura

- `index.html`: entrada con importmap para React 19 y ReactDOM desde CDN (esm.sh).
- `app.js`: aplicación React compilada previamente, lista para servir desde GitHub Pages.
- `src.tsx`: código fuente editable en TypeScript JSX.
- `styles.css`: estilos responsive, tema claro y oscuro.
- `scripts/build.mjs`: transpila TSX usando TypeScript global o local.
- `tests/check.mjs`: controles básicos de presencia de secciones y estructura.
- `.github/workflows/pages.yml`: despliegue continuo del sitio desde GitHub Actions.

**Aclaración:** La carga de React requiere conexión del navegador con `esm.sh`. Para despliegues totalmente sin conexión se recomienda fijar y servir localmente esas dependencias.

## Ejecutar

Coloque esta carpeta en un repositorio público y ejecute:

```bash
npm install --no-save typescript
npm run build
npm run check
python3 -m http.server 8000
```

Abra http://localhost:8000/ . `app.js` ya está compilado y no hace falta ejecutar el build solo para visualizarla. La configuración incluida publica desde la raíz del repositorio.

## Publicar en `amalvarezme`

**Opción más simple — publicación automatizada con GitHub CLI:**

```bash
gh auth login
bash scripts/publicar-github.sh
```

El script verifica que la sesión corresponda a `amalvarezme`, inicializa Git, crea el repositorio público si no existe, publica los archivos, comprueba GitHub Pages y solicita su habilitación si aún está desactivado. La ejecución requiere permisos adecuados de GitHub y el workflow de Pages puede tardar en finalizar.

**Alternativa manual: nuevo repositorio** llamado `sdlc-ia-estado-del-arte`:

1. Cree el repositorio público en `https://github.com/new` con ese nombre.
2. Desde la carpeta del proyecto ejecute:

```bash
git init
git branch -M main
git add .
git commit -m "feat: add SDLC IA research interactive site"
git remote add origin https://github.com/amalvarezme/sdlc-ia-estado-del-arte.git
git push -u origin main
```

3. En **Settings → Pages → Build and deployment** seleccione **GitHub Actions**.
4. Compruebe el resultado del workflow y el sitio `https://amalvarezme.github.io/sdlc-ia-estado-del-arte/` antes de comunicar su publicación.

**Alternativa sin repositorio nuevo:** copiar los archivos a la subcarpeta `estado-del-arte-ia/` dentro de `amalvarezme/IA-Agentes-Software`, manteniendo el `index.html` raíz y la presentación preexistente. El workflow de ese repositorio publica todos los archivos; el sitio quedaría en `https://amalvarezme.github.io/IA-Agentes-Software/estado-del-arte-ia/` una vez ejecutado correctamente. No debe sustituirse el archivo principal existente.

## Rigor de la evidencia

Se distingue entre ensayos aleatorizados, estudios observacionales, encuestas, benchmarks industriales, experimentos internos de n=1 y simulaciones económicas. Los resultados no comparten las mismas unidades y **no deben interpretarse como un ranking causal de frameworks**. El proyecto incluye enlaces a fuentes.

## Gentle-AI

- Proyecto: https://github.com/Gentleman-Programming/gentle-ai
- Versión de referencia: v4.2.0 (15 de octubre de 2026).
- Desde v4.0, su SDD antiguo fue reemplazado por ODD.
- ODD es proporcional a comprensión, riesgo y capacidad de reanudación; memoria Engram; pruebas test-first aplicables.
- RDD vincula revisión a un candidato exacto con supervisión humana; no autoriza publicar automáticamente.
- Gentle Shell es un entorno Pi separado y sus resultados n=1 no equivalen a validación multi-framework.

## Límites de pruebas

Se verificó que TypeScript emite JavaScript sintácticamente válido (`node --check`) y que están presentes las secciones esperadas. No se completó prueba visual E2E con navegador: el entorno bloqueó acceder al servidor localhost con Chromium. Antes de usar el sitio en producción, validar navegación, controles y responsive con navegador conectado y funcionamiento del CDN.
