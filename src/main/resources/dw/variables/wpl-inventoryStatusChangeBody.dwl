%dw 2.0
output application/json
import * from dw::util::Values
---
payload update {
     case order_id at .transaction.order_id -> vars.orderId
}