%dw 2.0
output application/json
---
{
    "sku": payload.ItemCode,
    "reason": "Sales order",
    "update": now() as String {format: 'dd-MM-yyyy hh:mm:ss'},
    "on_hand": randomInt(100) + 100,
    "allocated": payload.QuantityOrdered,
    "available": randomInt(50) + 50,
    "client_id": p('mule.p-inventory.client_id'),
    "client_secret": p('mule.p-inventory.client_secret')
}