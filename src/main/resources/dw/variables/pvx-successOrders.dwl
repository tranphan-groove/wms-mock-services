%dw 2.0
output application/json
---
(vars.successOrders default []) ++ 
[{SalesOrderNumber: payload.SalesOrderNumber default ""}]