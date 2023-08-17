%dw 2.0
output application/x-www-form-urlencoded
---
{
	so_num: payload.SalesOrderNumber,
	status: 'Allocated',
	site: payload.Site
}