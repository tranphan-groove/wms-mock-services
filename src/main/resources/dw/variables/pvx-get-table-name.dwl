%dw 2.0
output application/java
---
"wmsmock_pvx_" ++ (lower (vars.templateName replace " " with "_"))