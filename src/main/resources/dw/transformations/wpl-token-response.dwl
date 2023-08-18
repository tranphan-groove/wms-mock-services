%dw 2.0
output application/json
---
{
	access_token: uuid(),
	refresh_token: uuid(),
	created_at: now() as Number,
	expires_in: 900000
}