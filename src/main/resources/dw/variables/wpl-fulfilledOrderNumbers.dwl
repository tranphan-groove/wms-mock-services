%dw 2.0
output application/json
---
(vars.fulfilledOrderNumbers default []) ++ [payload.order.order_orig default ""]