%dw 2.0
output application/json
---
{
	header: vars.generatedAUOrders.header,
	data: (vars.generatedAUOrders.data default []) ++ (vars.generatedUSOrders.data default [])
}