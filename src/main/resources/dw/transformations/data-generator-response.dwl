%dw 2.0
output application/json
---
{
    code: 200,
    testData: "/generated-data/" ++ vars.osKeyPrefix,
    mockServiceData: "/generated-data/" ++ vars.osKeyPrefix ++ "?dataType=mock-service",
    message: "Data has been generated and will be expired in 5 minutes (" ++ ((now() + |PT0H5M0S|) as String {format: 'MM/dd/YYYY hh:mm:ss'}) ++ ")"
}