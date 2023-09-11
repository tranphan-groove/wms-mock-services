%dw 2.0
output application/json
---
(vars.successOrderNumbers default []) ++ 
(([payload.order.order_orig default ""]) map ((orderNumber) -> {
	order_orig: orderNumber
}))