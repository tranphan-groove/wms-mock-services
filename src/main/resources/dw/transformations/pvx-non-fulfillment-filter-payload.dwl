%dw 2.0
output application/xml  
ns soap http://www.w3.org/2003/05/soap-envelope
var transformedPayload = []
---
{
    soap#Envelope @("xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance", "xsi:xsd":"http://www.w3.org/2001/XMLSchema"): {
        soap#Body: {
            GetReportDataResponse @("xmlns": "http://www.peoplevox.net/"): {
                GetReportDataResult: {
                    ResponseId: 0,
                    TotalCount: sizeOf(transformedPayload),
                    Detail: write(transformedPayload, 'application/csv', {header:true, quoteValues:true, quoteHeader:true}),
                    Statuses: null
                }
            }
        }
    }
}
