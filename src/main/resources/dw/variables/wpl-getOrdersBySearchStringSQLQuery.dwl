%dw 2.0
output application/java
var search = read(attributes.queryParams.search, 'application/json')
var searchConditions = (search pluck ((value, key, index) -> {
    key: '(JSON_EXTRACT(data, "\$.' ++ (key splitBy '_eq')[0] ++ '") = "' ++ value ++ '")'
})).key
---
'SELECT data FROM wmsmock_wpl_sales_orders WHERE ' ++ (searchConditions joinBy ' AND ')