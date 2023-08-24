%dw 2.0
output application/json
import * from dw::util::Timer
import * from dw::util::Values
var shipnoticeId = currentMilliseconds() + randomInt(500)
---
vars.inventoryBody update {
     case shipnotice_id at .transaction.shipnotice_id -> shipnoticeId
}