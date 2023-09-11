%dw 2.0
output application/json
---
(vars.successOrders default []) ++ 
[{order_orig: payload.order.order_orig default ""}]