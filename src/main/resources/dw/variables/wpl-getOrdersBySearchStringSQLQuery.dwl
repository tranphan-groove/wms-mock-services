%dw 2.0
output application/java
var search = read(attributes.queryParams.search default '{}', 'application/json')
var searchConditions = (
    search pluck (
        (value, key, index) -> do {
            var newVal = (
                if (typeOf(value) ~= 'Array')
                    '(' ++ ((value map ((item) -> '"' ++ item ++ '"')) joinBy ',') ++ ')'
                else if (key endsWith('_cont_any'))
                    '("' ++ value ++ '")'
                else '"' ++ value ++ '"'
            )
            var conditon = (
                if (key endsWith('_eq'))
                    '(JSON_EXTRACT(data, "\$.' ++ (key splitBy '_eq')[0] ++ '") = ' ++ newVal ++ ')'
                else if (key endsWith('_cont_any'))
                    '(JSON_EXTRACT(data, "\$.' ++ (key splitBy '_cont_any')[0] ++ '") IN ' ++ newVal ++ ')'
                else ''
            )
            ---
            {
                key: conditon
            }
        }
    )
).key
---
'SELECT data FROM wmsmock_wpl_sales_orders' ++ (
    if (isEmpty(searchConditions)) ''
    else ' WHERE ' ++ (searchConditions joinBy ' AND ')
)