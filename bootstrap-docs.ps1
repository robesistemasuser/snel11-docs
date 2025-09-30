# (contenido del script)
Write-Host "Creando docs..."
New-Item -ItemType Directory -Force -Path docs/_generated, docs/architecture, docs/modules/inventories, docs/operations, docs/purchases, docs/adr, .github/workflows | Out-Null
"# SNEL11 Docs`n" | Set-Content -Encoding UTF8 docs/index.md
# mkdocs.yml mínimo
@"
site_name: SNEL11 Docs
nav:
  - Inicio: docs/index.md
theme:
  name: material
markdown_extensions:
  - toc:
      permalink: true
  - admonition
  - pymdownx.details
  - pymdownx.superfences
"@ | Set-Content -Encoding UTF8 mkdocs.yml
# workflow de Pages
$workflow = @'
name: Deploy Docs (MkDocs → GitHub Pages)

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Install MkDocs
        run: |
          pip install mkdocs mkdocs-material

      - name: Build site
        run: mkdocs build --strict --site-dir site

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: site

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
'@ | Set-Content -Encoding UTF8 .github/workflows/pages.yml
Write-Host " Archivos base creados."
