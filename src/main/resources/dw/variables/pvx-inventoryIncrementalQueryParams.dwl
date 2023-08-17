%dw 2.0
output application/json
---
{
    "type": "Adjustment",
    "sku": payload.ItemCode,
    "reason": "Sales order",
    "updated": now() as String {format: 'dd-MM-yyyy hh:mm:ss'},
    "qty_changed": randomInt(90) + 10,
    "history_id": now() as Number,
    "client_id": p('mule.client_id'),
    "client_secret": p('mule.client_secret')
}