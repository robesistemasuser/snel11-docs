
---

### `docs/architecture/actions.md`
```md
# Actions (patrón)

Centralizan **reglas** y **validaciones**:
- Reutilizables por Livewire, API y procesos masivos (import).
- Ejemplos:  
  `CreateInventoryCategory`, `UpdateInventoryCategory`,  
  `InventoryCategoriesList`, `InventoryCategoryFinder`.

## Buenas prácticas
- Validar *inputs* (FormRequest o validación interna).
- Retornar estructura clara: `{ success, message, data?, errors? }`.
- Registrar auditoría cuando aplique.
- Manejar transacciones cuando afecte >1 modelo.
