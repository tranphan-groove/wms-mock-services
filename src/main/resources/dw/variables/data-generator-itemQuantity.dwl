%dw 2.0
output application/java
---
{
	US: (attributes.queryParams.USItemQuantity as Number) default 1,
	AU: (attributes.queryParams.AUItemQuantity as Number) default 1
}