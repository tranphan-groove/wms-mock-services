%dw 2.0
output application/json
---
(payload.Envelope.Body.GetReportData.getReportRequest.SearchClause splitBy '[Sales order number].Contains("RPLN")')[0] == "["