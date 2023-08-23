%dw 2.0
output application/xml  
ns soap http://www.w3.org/2003/05/soap-envelope
var salesOrders = (vars.salesOrders.data map ((item) -> {(read(item))}))
var salesOrderItems = (vars.salesOrderItems.data map ((item) -> {(read(item))}))
var transformedPayload = flatten((salesOrders filter ((item) -> (
    ((vars.searchClauseRPLN and (item.SalesOrderNumber contains "RPLN")) or ((vars.searchClauseRPLN == false and !(item.SalesOrderNumber contains "RPLN")))) and
    (isEmpty(vars.searchClauseTimestamps[0]) or ((item.timestamp as DateTime) > (vars.searchClauseTimestamps[0] as DateTime))) and
    (isEmpty(vars.searchClauseTimestamps[1]) or ((item.timestamp as DateTime) < (vars.searchClauseTimestamps[1] as DateTime)))
))) map ((order) -> (salesOrderItems filter ((item) -> item.SalesOrderNumber == order.SalesOrderNumber)) map ((item) -> {
      "Sales order number": order.SalesOrderNumber default "",
      "Package number": item.QuantityOrdered default "",
      "Item code": item.ItemCode default "",
      "Item quantity": item.QuantityOrdered default "",
      "Package despatch timestamp": ("'" ++ order.timestamp as DateTime as String {format: 'dd/MM/yyyy hh:mm'} ++ "'") default "",
      "Package tracking number": "Staff Order - Picking under stairs at HQ",
      "Sales order item quantity ordered": item.QuantityOrdered default "",
      "Shipping address line 1": order.ShippingAddressLine1 default "",
      "Shipping address line 2": order.ShippingAddressLine2 default "",
      "Shipping address town": order.ShippingAddressCity default "",
      "Shipping address region": order.ShippingAddressRegion default "",
      "Shipping address postcode": order.ShippingAddressPostcode default "",
      "Shipping address country": "Australia",
      "Sales order is partial despatched": "0",
      "Sales order status": "Despatched",
      "Sales order shipping cost": order.ShippingCost default "",
      "Sales order contact name": order.ContactName default "",
      "Sales order attribute 1": order.Attribute1 default "",
      "Sales order attribute 2": order.Attribute2 default "",
      "Sales order attribute 3": order.Attribute3 default "",
      "Sales order attribute 4": order.Attribute4 default "",
      "Sales order attribute 5": order.Attribute5 default "",
      "Despatch number of packages": item.QuantityOrdered default "",
      "Despatch carrier name": "DC Pickup",
      "Despatch service type code": "DCPickup-StaffOrderPickup",
      "Package carrier name": "DC Pickup",
      "Package service type code": "DCPickup-StaffOrderPickup",
      "Site reference": order.Site default "",
      "Channel name": order.ChannelName default "",
      "Despatch number": "DES" ++ (order.SalesOrderNumber default ""),
      "Package identifier": order.SalesOrderNumber default "",
      "Package weight": "0.00",
      "Package height": "0.00",
      "Package width": "0.00",
      "Package depth": "0.00",
      "Package weight unit of measure": "Kilogram",
      "Package height unit of measure": "Centimetre",
      "Package width unit of measure": "Centimetre",
      "Package depth unit of measure": "Centimetre",
      "Package tracking number timestamp": ("'" ++ order.timestamp as DateTime as String {format: 'dd/MM/yyyy hh:mm'} ++ "'") default "",
    })
))
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
