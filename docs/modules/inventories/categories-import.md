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

