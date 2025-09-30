
---

### `docs/purchases/classes-permissions.md`
```md
# Compras — Diagrama de clases y permisos

```mermaid
classDiagram
  class PurchaseOrder{ id; number; status; total; supplier_id; area_id?; created_by; approved_by?; emitted_by? }
  class PurchaseOrderItem{ id; purchase_order_id; article_id?; category_id; qty; unitPrice }
  class Supplier{ id; name; taxId; isActive }
  class Reception{ id; purchase_order_id; number; received_at; received_by }
  class ReceptionItem{ id; reception_id; purchase_order_item_id; qty_received }
  class Invoice{ id; purchase_order_id; number; issued_at; total }
  class Article{ id; name; sku; category_id }
  class Warehouse{ id; name }
  class InventoryCategory{ id; name; code?; inventory_category_type_id; approve_area_id? }
  PurchaseOrder o-- PurchaseOrderItem
  PurchaseOrder o-- Reception
  Reception o-- ReceptionItem
  PurchaseOrder o-- Invoice
  PurchaseOrderItem --> Article
  PurchaseOrderItem --> InventoryCategory
