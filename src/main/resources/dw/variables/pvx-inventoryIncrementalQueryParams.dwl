%dw 2.0
import * from dw::util::Timer
output application/json
---
{
    "type": "Adjustment",
    "sku": payload.ItemCode,
    "reason": "Sales order",
    "updated": now() as String {format: 'dd-MM-yyyy hh:mm:ss'},
    "qty_changed": randomInt(90) + 10,
    "history_id": currentMilliseconds(),
    "client_id": p('mule.p-inventory.client_id'),
    "client_secret": p('mule.p-inventory.client_secret')
}