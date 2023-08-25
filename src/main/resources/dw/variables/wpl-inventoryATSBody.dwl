%dw 2.0
output application/json
import * from dw::util::Timer
import * from dw::util::Values
---
vars.inventoryBody update {
     case shipnotice_id at .transaction.shipnotice_id -> currentMilliseconds()
     case id at .transaction.id -> currentMilliseconds()
     case created_at at .transaction.created_at -> now()
     case updated_at at .transaction.updated_at -> now()
     case description at .transaction.description -> ("Allocated Inventory, +" ++ payload.quantity)
}