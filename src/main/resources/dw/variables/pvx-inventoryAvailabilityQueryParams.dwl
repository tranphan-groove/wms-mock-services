%dw 2.0
output application/json
---
{
    "sku": payload.ItemCode,
    "reason": "Sales order",
    "update": now() as String {format: 'dd-MM-yyyy hh:mm:ss'},
    "on_hand": randomInt(40) + 10,
    "allocated": payload.QuantityOrdered,
    "available": randomInt(40000) + 10000,
    "client_id": p('mule.p-inventory.client_id'),
    "client_secret": p('mule.p-inventory.client_secret')
}