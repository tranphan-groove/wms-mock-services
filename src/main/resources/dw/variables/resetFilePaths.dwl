%dw 2.0
output application/json
---
if (isEmpty(attributes.queryParams.filePath))
	p('filePaths') splitBy ','
else
	[attributes.queryParams.filePath]