%dw 2.0
output application/json
---
read(attributes.queryParams.search, 'application/json')