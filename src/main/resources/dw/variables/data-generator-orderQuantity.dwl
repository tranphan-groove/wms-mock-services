%dw 2.0
output application/java
---
{
	US: (attributes.queryParams.USOrderQuantity as Number) default 0,
	AU: (attributes.queryParams.AUOrderQuantity as Number) default 0
}