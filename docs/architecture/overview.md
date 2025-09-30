# Visión general

**Stack:** Laravel + Livewire + Blade + Vite + Tailwind + AlpineJS.  
**Patrón de negocio:** *Actions* (Create/Update/List/Delete/Finder).  
**Autorización por submódulos:** middleware `SubmoduleAccess` (valida `route()->getName()` contra `route_names` por área/rol).

## Principios
- **UI delgada** (Livewire) + **Actions ricas** (reglas y validaciones en un solo lugar).
- **DTOs / arrays validados** entre UI y Actions.
- **Export/Import**: endpoints dedicados (Controllers) que invocan Actions.
- **Mensajería de usuario**: siempre feedback (success/errors detallados).

## Módulos actuales (alto nivel)
- **Inventarios**: Categorías, Tipos, Artículos, Bodegas, Compras, etc.
- **Parametrización**: Áreas, Roles, Documentos, etc.
- **Operación / Programación / Inspecciones / Novedades**.
