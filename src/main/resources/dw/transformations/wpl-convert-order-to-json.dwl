%dw 2.0
output application/json
---
(payload.data default []) map ((item) -> read(item, 'application/json'))