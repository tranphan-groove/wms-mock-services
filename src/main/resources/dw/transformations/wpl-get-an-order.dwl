%dw 2.0
output application/json
---
read(payload.data[0]) default null