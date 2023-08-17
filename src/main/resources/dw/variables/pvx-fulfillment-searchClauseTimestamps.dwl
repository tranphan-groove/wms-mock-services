%dw 2.0
import * from dw::core::Dates
output application/json
fun convertToDateTime(dateString) = do {
    var dateComponents = dateString splitBy ","
    ---
    dateTime({
        year: dateComponents[0] as Number, 
        month: dateComponents[1] as Number, 
        day: dateComponents[2] as Number, 
        hour: dateComponents[3] as Number, 
        minutes: dateComponents[4] as Number, 
        seconds: dateComponents[5] as Number, 
        timeZone: |+00:00|
    })
}
fun extractTimestampFromSearchClause(searchClause) = ((searchClause splitBy 'OR')[0] scan /DateTime\(([^)]+)\)/) map ((item) -> convertToDateTime(item[1]))
---
extractTimestampFromSearchClause(payload.Envelope.Body.GetReportData.getReportRequest.SearchClause)
