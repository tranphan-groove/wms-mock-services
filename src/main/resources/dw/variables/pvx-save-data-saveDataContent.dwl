%dw 2.0
output application/json
---
read(payload.Envelope.Body.SaveData.saveRequest.CsvData, 'application/csv')