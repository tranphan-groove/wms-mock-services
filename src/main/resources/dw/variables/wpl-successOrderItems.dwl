%dw 2.0
output application/json
---
(vars.successOrderItems default []) ++ 
[{
	order_orig: vars.orderNumber default "",
	sku: vars.itemSku default ""
}]