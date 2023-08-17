%dw 2.0
import * from dw::Runtime
output application/json
---
{} wait ((p('blazemeter-mock-service.wait') as Number) * 1000)