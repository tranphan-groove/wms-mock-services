%dw 2.0
output application/json
import * from dw::util::Timer
import * from dw::util::Values
---
vars.inventoryBody update {
     case order_id at .transaction.order_id -> vars.orderId
     case id at .transaction.id -> currentMilliseconds()
     case created_at at .transaction.created_at -> now()
     case updated_at at .transaction.updated_at -> now()
     case description at .transaction.description -> ("Added items to Order " ++ vars.orderId ++ "-" ++ vars.orderNumber ++", +" ++ payload.quantity)
}