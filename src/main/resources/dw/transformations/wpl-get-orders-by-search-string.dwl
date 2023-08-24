%dw 2.0
import * from dw::core::Arrays
output application/json
---
((payload.data default []) map ((item) -> {(read(item))})) filter ((order) -> (
    !(keysOf(vars.search) some ((key) -> !(vars.search[key] contains order[(key splitBy '_eq')[0]])))
))