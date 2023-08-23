%dw 2.0
output application/json
---
(payload.data map ((item) -> {(read(item))}))