# Permisos — SubmoduleAccess

`App\Http\Middleware\SubmoduleAccess`:
1. Verifica que el usuario esté **autenticado**.
2. Recolecta `route_names` permitidos por **área** y **rol** (vía permisos y vínculos a submódulos).
3. Compara `request()->route()->getName()` con la lista **permitida**.

## Recomendación con subrutas
Si el submódulo tiene rutas hijas (ej. `inventory.categories.template` e `inventory.categories.import`):

- Opción A: **Añadir los `route_names` hijos** a ese submódulo.
- Opción B (más flexible): permitir prefijos:

```php
$routeName = $request->route()->getName();
if (in_array($routeName, $pathNames)) return $next($request);
foreach ($pathNames as $allowed) {
    if (str_starts_with($routeName, $allowed . '.')) return $next($request);
}
abort(403);
