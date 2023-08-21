%dw 2.0
output application/json
---
{
    code: 404,
    testData: server.host,
    mockServiceData: "",
    message: "Data has been generated and will be expired in 5 minutes (" ++ ((now() + |PT0H5M0S|) as String {format: 'MM/dd/YYYY hh:mm:ss'}) ++ ")"
}