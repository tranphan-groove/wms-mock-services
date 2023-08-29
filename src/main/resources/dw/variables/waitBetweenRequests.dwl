%dw 2.0
import * from dw::Runtime
output application/json
---
{} wait ((p('blazemeter-mock-service.waitBetweenRequests') as Number) * 1000)