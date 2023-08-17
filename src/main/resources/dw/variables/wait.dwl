%dw 2.0
import * from dw::Runtime
output application/json
---
{} wait ((p('peoplevox.inventory.wait') as Number) * 1000)