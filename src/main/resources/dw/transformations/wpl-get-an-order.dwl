%dw 2.0
output application/json
---
(vars.fileContent filter ((order) -> order.order_orig == attributes.uriParams.id))[0]