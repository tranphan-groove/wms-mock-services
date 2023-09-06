%dw 2.0
output application/java
---
payload.order_orig replace /[a-zA-Z]/ with ("")