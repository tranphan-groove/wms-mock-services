%dw 2.0
output application/json
---
"pvx/" ++ (lower (vars.templateName replace " " with "-")) ++ ".csv"