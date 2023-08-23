%dw 2.0
output application/java
---
"attachment;filename=mock-service-data-" ++ (vars.orderType default "") ++ "-" ++ (vars.datakey default "") ++ ".csv"