%dw 2.0
output application/json
---
payload ++ {id: now() as Number}