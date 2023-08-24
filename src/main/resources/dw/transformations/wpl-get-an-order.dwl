%dw 2.0
output application/json
---
(((payload.data default []) map ((item) -> {(read(item))})) filter ((order) -> order.order_orig == vars.id))[0]