%dw 2.0
output application/json
---
{
    "client_id": p('mule.p-forders-pub.client_id'),
    "client_secret": p('mule.p-forders-pub.client_secret')
}