%dw 2.0
import * from dw::Runtime
output application/json
---
{} wait ((p('outbound.waitAfterFinishFlow') as Number) * 1000)