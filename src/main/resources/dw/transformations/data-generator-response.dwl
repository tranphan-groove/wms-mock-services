%dw 2.0
output application/json
import * from dw::core::Periods
---
if (vars.orderQuantity.US > 0 or vars.orderQuantity.AU > 0) {
    code: 200,
    (testAUData: "/generated-data/" ++ vars.osKeyPrefix ++ "?orderType=AU") if (vars.orderQuantity.AU > 0),
    (testUSData: "/generated-data/" ++ vars.osKeyPrefix ++ "?orderType=US") if (vars.orderQuantity.US > 0),
    (mockServiceAUData: "/generated-data/" ++ vars.osKeyPrefix ++ "?dataType=mock-service&orderType=AU") if (vars.orderQuantity.AU > 0),
    (mockServiceUSData: "/generated-data/" ++ vars.osKeyPrefix ++ "?dataType=mock-service&orderType=US") if (vars.orderQuantity.US > 0),
    message: "Data has been generated and will be expired in " ++ p('object-store.ttl') ++ " minutes (" ++ ((now() + minutes(p('object-store.ttl'))) as String {format: 'MM/dd/YYYY hh:mm:ss'}) ++ ")"
}
else {
	code: 200,
    message: "No data has been generated"
}