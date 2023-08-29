%dw 2.0
output application/java
var searchConditions = [
    (if (vars.searchClauseRPLN) '' else 'not ') ++ '(JSON_UNQUOTE(JSON_EXTRACT(wmsmock_pvx_sales_orders.data, "\$.SalesOrderNumber")) LIKE "RPLN%")',
    if (isEmpty(vars.searchClauseTimestamps[0])) 'TRUE' else '(wmsmock_pvx_sales_orders.created_at > "' ++ (vars.searchClauseTimestamps[0] as String {format:'yyyy-MM-dd hh:mm:ss'}) ++ '")',
    if (isEmpty(vars.searchClauseTimestamps[1])) 'TRUE' else '(wmsmock_pvx_sales_orders.created_at < "' ++ (vars.searchClauseTimestamps[1] as String {format:'yyyy-MM-dd hh:mm:ss'}) ++ '")'
]
---
'SELECT wmsmock_pvx_sales_order_items.data as order_item_data, wmsmock_pvx_sales_orders.data as order_data FROM wmsmock_pvx_sales_orders INNER JOIN wmsmock_pvx_sales_order_items ON (JSON_EXTRACT(wmsmock_pvx_sales_orders.data, "\$.SalesOrderNumber") = JSON_EXTRACT(wmsmock_pvx_sales_order_items.data, "\$.SalesOrderNumber")) AND ' ++ (searchConditions joinBy ' AND ')