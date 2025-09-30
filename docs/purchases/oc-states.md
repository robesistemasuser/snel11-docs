# Compras — Estados de Órdenes de Compra

```mermaid
stateDiagram-v2
  [*] --> Borrador
  Borrador --> EnRevision: Enviar a revisión
  EnRevision --> Aprobada: Aprobar
  EnRevision --> Rechazada: Rechazar
  Aprobada --> Emitida: Emitir OC
  Emitida --> ParcialmenteRecibida: Recepción parcial
  ParcialmenteRecibida --> Recibida: Recepción total
  Emitida --> Recibida: Recepción total
  Recibida --> Cerrada: Cerrar
  Rechazada --> Borrador: Corregir
  Borrador --> Cancelada: Cancelar
  EnRevision --> Cancelada: Cancelar
  Aprobada --> Cancelada: Cancelar
