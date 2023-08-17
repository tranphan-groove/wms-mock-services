%dw 2.0
output application/java
---
if (!isEmpty(payload.Envelope.Body.SaveData.saveRequest.TemplateName))
	payload.Envelope.Body.SaveData.saveRequest.TemplateName
else
	payload.Envelope.Body.GetReportData.getReportRequest.TemplateName