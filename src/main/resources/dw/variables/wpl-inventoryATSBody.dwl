%dw 2.0
output application/json
import * from dw::util::Values
var shipnoticeId = (now() as Number) + randomInt(500)
---
payload update {
     case shipnotice_id at .transaction.shipnotice_id -> shipnoticeId
}