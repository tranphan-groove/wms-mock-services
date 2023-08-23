%dw 2.0
output application/java
---
"attachment;filename=test-data-" ++ (vars.datakey default "") ++ ".csv"