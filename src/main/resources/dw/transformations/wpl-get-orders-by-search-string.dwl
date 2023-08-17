%dw 2.0
import * from dw::core::Arrays
output application/json
var searchObj = read(attributes.queryParams.search, 'application/json')
---
vars.fileContent filter ((order) -> (
    !(keysOf(searchObj) some ((key) -> !(searchObj[key] contains order[(key splitBy '_eq')[0]])))
))