# bootstrap-docs.ps1
# Crea estructura, escribe contenido .md y mkdocs.yml, y agrega workflow de Pages.

$ErrorActionPreference = "Stop"

# 1) Carpetas
New-Item -ItemType Directory -Force -Path docs/_generated, docs/architecture, docs/modules/inventories, docs/operations, docs/purchases, docs/adr, .github/workflows | Out-Null

# 2) Contenidos
$readme = @"
# SNEL11 — Documentación (Índice principal)

Este sitio agrupa la documentación técnica y funcional del proyecto.

## Índice
- **Arquitectura**
  - [Visión general](architecture/overview.md)
  - [Módulos (catálogo)](architecture/modules.md)
  - [Permisos — SubmoduleAccess](architecture/permissions.md)
  - [Actions (patrón)](architecture/actions.md)
  - [ERD + Secuencias Inventarios](architecture/inventories-erd-sequences.md)
- **Módulos**
  - [Inventarios / Categorías (Importación masiva)](modules/inventories/categories-import.md)
- **Compras**
  - [Estados de Órdenes de Compra](purchases/oc-states.md)
  - [Clases y permisos](purchases/classes-permissions.md)
- **Operaciones**
  - [Entorno local](operations/local-setup.md)
  - [Despliegue](operations/deploy.md)
  - [Troubleshooting](operations/troubleshooting.md)
- **Generados** (no editar a mano)
  - [Rutas](../_generated/routes.md)
  - [Modelos](../_generated/models.md)
  - [Livewire](../_generated/livewire-components.md)
  - [Migraciones](../_generated/migrations.md)

## Cómo regenerar documentación
- Ver `operations/local-setup.md`.
- Scripts de generación al final de `operations/troubleshooting.md`.
"@

$overview = @"
# Visión general

- **Framework**: Laravel + Livewire + Vite + Tailwind.
- **Front**: Blade + componentes Livewire; AlpineJS para micro-interacciones.
- **Back**: patrón **Actions** para lógica de negocio reutilizable (Create/Update/List/Delete).
- **Permisos**: middleware `SubmoduleAccess` valida `route()->getName()` contra `route_names` por submódulo/área.
- **Módulos**: Inventarios, Parametrización, Compras, Operación, Programación, Novedades/Eventos, etc.

## Principios
- UI delgada, **Actions** ricas.
- Endpoints auxiliares (Controllers) para **export/import** de archivos.
- Validaciones y reglas de negocio centralizadas.
"@

$modules = @"
# Catálogo de módulos

Este documento lista módulos y submódulos (a partir de `routes/web.php`).

## Inventarios
- **Categorías** — `inventory.categories` — Livewire: `...Inventories\Categories\InventoryCategoriesComponent`
- **Tipos de categoría** — `inventory.categoryTypes`
- **Bodegas** — `inventory.warehouses`
- **Proveedores** — `inventory.suppliers`
- **Artículos** — `inventory.articles`
- **Mantenimientos** — `inventory.maintenances`
- **Garantías** — `inventory.warranties`
- **Salidas** — `inventory.outputs`
- **Reintegros** — `inventory.refunds`
- **Compras**:
  - Cotizaciones — `inventory.shopping.quotes`
  - Órdenes de compra — `inventory.shopping.purchaseOrders`
  - Compras realizadas — `inventory.shopping.purchasesMade`
- **Requisiciones** — `inventory.requisitions`

## Parametrización
- Áreas — `parameterization.areas`
- Tipos de documentos — `parameterization.documentTypes`
- Roles — `parameterization.roles`
- ... (ver más en `routes/web.php`)

## Otros
- Negociaciones — `bidding.*`
- Operación — `operations`, `operations.show`
- Programación — `programations`, `programation.show`
- Novedades/Eventos — `events`, `novelties`
"@

$modulesTemplates = @"
# SNEL11 — Plantillas por módulo

> Copia esta ficha para cada submódulo y complétala.

## Plantilla
**Ruta**: `{uri}`  
**Route name**: `{route.name}`  
**Livewire**: `{FQCN}`  
**Propósito**: {qué resuelve}  
**Usuarios**: {roles/perfiles}

### Componentes/UI
- {pantallas, modales, filtros}

### Modelos y relaciones
- {ModelA} 1—* {ModelB}

### Actions
- Create...
- Update...
- Delete...
- List/Finder...

### Reglas de negocio
- {validaciones, estados, transiciones}

### Permisos
- `{route.name}`, ...

### Integraciones
- {servicios externos, colas, jobs}

### Reportes/KPIs
- {métricas}
"@

$permissions = @"
# Permisos — SubmoduleAccess

`App\Http\Middleware\SubmoduleAccess`:
- Recolecta `route_names` permitidos por submódulo/área desde roles/permisos.
- Valida: `request()->route()->getName()` debe estar en esa lista.

## Rutas hijas
Para permitir subrutas (p. ej. `inventory.categories.template`):
- Añádelas a `route_names` del submódulo **o**
- Permite prefijo:

```php
$routeName = $request->route()->getName();
if (in_array($routeName, $pathNames)) return $next($request);
foreach ($pathNames as $allowed) {
  if (str_starts_with($routeName, $allowed . '.')) return $next($request);
}
abort(403);
