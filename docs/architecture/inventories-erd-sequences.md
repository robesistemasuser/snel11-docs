# Inventarios — ERD + Secuencias

## ERD (simplificado)
```mermaid
erDiagram
  Area ||--o{ InventoryCategory : "gestiona (N..M via pivot)"
  Area ||--o{ InventoryCategory : "aprueba (1) -> approve_area_id"
  InventoryCategoryType ||--o{ InventoryCategory : "tiene"
  InventoryCategory ||--o{ Article : "clasifica"
