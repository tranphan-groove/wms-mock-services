%dw 2.0
output application/json
---
{
    "client_id": p('mule.p-inventory-whip.client_id'),
    "client_secret": p('mule.p-inventory-whip.client_secret')
}