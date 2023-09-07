%dw 2.0
import * from dw::Runtime
output application/json
---
{} wait ((p('outbound.waitBeforeCallingInventoryRequest') as Number) * 1000)