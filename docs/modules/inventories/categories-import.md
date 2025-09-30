# Importación masiva de Categorías

## 1. Descargar plantilla
- Ruta: `GET inventario/categorias/plantilla` (`inventory.categories.template`)
- Contenido:
  - **Categorias** (para que el usuario llene)
  - **Tipos de categoria** (solo lectura)
  - **Areas** (solo lectura)

## 2. Cargar archivo
- Ruta: `POST inventario/categorias/importar` (`inventory.categories.import`)
- Validación:
  - `Categoria` y `Tipo de categoria` obligatorios.
  - Áreas separadas por coma.
- Upsert:
  - Si `code`, se usa `code`.
  - Si no, `(name + inventory_category_type_id)`.
- Respuesta:
  - `session('success')`, `session('report')` con creados/actualizados/errores.

## Reutilización de Actions
- `CreateInventoryCategory` y `UpdateInventoryCategory`.

## Mensajería
- `session('success')` + `session('report')` con:
  - `creados`, `actualizados`, `errores`, `avisos`.

## Errores frecuentes
- **403**: faltan `route_names` (`inventory.categories.template` / `.import`).
- **Maatwebsite Excel**: usar `SkipsOnError` + traits `SkipsErrors`, `SkipsFailures`.

## Flujo: Descargar plantilla Categorías
sequenceDiagram
  participant U as Usuario
  participant L as Livewire: InventoryCategories
  participant R as Router
  participant C as Controller: InventoryCategoriesMassController
  participant E as Excel: CategoriesTemplateExport
  U->>L: Clic ▾ → Descargar estructura
  L->>R: GET /inventario/categorias/plantilla
  R->>C: download()
  C->>E: construir 3 sheets
  E-->>C: XLSX
  C-->>U: plantilla_categorias.xlsx

## Flujo: Importar

sequenceDiagram
  participant U as Usuario
  participant L as Livewire (modal)
  participant R as Router
  participant C as InventoryCategoriesMassController
  participant I as CategoriesImport
  participant A as Actions
  U->>L: Subir Excel
  L->>R: POST /inventario/categorias/importar
  R->>C: import()
  C->>I: Excel::import
  I->>A: upsert por code o (name+type)
  A-->>I: resultado
  I-->>C: reporte
  C-->>L: back + session(report)
