
---

### `docs/operations/troubleshooting.md`
```md
# Troubleshooting

## 403 al descargar/importar plantilla
- Añadir `inventory.categories.template` y `inventory.categories.import` a `route_names` o permitir prefijo (`inventory.categories.*`) en `SubmoduleAccess`.

## Excel import: error `SkipsErrors`
- Implementar `SkipsOnError` + traits `SkipsErrors`, `SkipsFailures`, `Importable`.

## CSRF en POST
- Verifica `@csrf` en formularios.

## Rendimiento import
- `ShouldQueue` + `WithChunkReading`.

---

## Generar `_generated` (local)
```powershell
New-Item -ItemType Directory -Force -Path docs/_generated | Out-Null
php artisan route:list | Out-File -FilePath docs/_generated/routes.md -Encoding UTF8
Get-ChildItem app/Models -Recurse -Filter *.php | %% { $_.FullName.Replace($pwd.Path,'').TrimStart('\\') } | Out-File docs/_generated/models.md -Encoding UTF8
Get-ChildItem app/Livewire -Recurse -Filter *.php | %% { $_.FullName.Replace($pwd.Path,'').TrimStart('\\') } | Out-File docs/_generated/livewire-components.md -Encoding UTF8
Get-ChildItem database/migrations -Recurse -Filter *.php | Sort-Object Name | %% { $_.Name } | Out-File docs/_generated/migrations.md -Encoding UTF8
