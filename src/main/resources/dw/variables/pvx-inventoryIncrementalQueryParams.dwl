%dw 2.0
import * from dw::util::Timer
output application/json
var orderId = payload.SalesOrderNumber replace /[a-zA-Z]/ with ("")
---
{
    "type": "Adjustment",
    "sku": payload.ItemCode,
    "reason": "Sales order",
    "updated": now() as String {format: 'dd-MM-yyyy hh:mm:ss'},
    "qty_changed": payload.QuantityOrdered,
    "history_id": (currentMilliseconds() ++ orderId) as Number,
    "client_id": p('mule.p-inventory.client_id'),
    "client_secret": p('mule.p-inventory.client_secret')
}