%dw 2.0
output application/java
---
{
	US: attributes.queryParams.USHeader,
	AU: attributes.queryParams.AUHeader
}