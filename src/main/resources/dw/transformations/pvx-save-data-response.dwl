%dw 2.0
output application/xml  
ns soap http://www.w3.org/2003/05/soap-envelope
---
{
    soap#Envelope @("xmlns:xsi": "http://www.w3.org/2001/XMLSchema-instance", "xsi:xsd":"http://www.w3.org/2001/XMLSchema"): {
        soap#Body: {
            SaveDataResponse @("xmlns": "http://www.peoplevox.net/"): {
                SaveDataResult: {
                    ResponseId: 0,
                    TotalCount: sizeOf(vars.saveDataContent),
                    Detail: null,
                    Statuses: {
                        IntegrationStatusResponse: vars.saveDataContent map ((item, index) -> {
                            Reference: (
                                if (vars.templateName == "Sales Orders") item.SalesOrderNumber
                                else if (vars.templateName == "Sales Order Items") (item.SalesOrderNumber ++ ' - ' ++ item.ItemCode)
                                else item.Reference
                            ),
                            Status: "Success",
                            LineNo: index + 1
                        })
                    }
                }
            }
        }
    }
}