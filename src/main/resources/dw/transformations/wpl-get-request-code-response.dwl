%dw 2.0
output application/java
---
'<html><body>You are being <a href="' ++ vars.callbackURI ++ '?code=' ++ p('whiplash.code') ++ '">redirected</a>.</body></html>'