%dw 2.0
import * from dw::core::URL
output application/json
---
parseURI(vars.callbackURI default "")