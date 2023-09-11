%dw 2.0
output application/json
---
(vars.successOrderItems default []) ++ 
[{
	SalesOrderNumber: payload.SalesOrderNumber default "",
	ItemCode: payload.ItemCode default "",
}]