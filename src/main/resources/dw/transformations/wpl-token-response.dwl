%dw 2.0
output application/json
---
{
	access_token: p('whiplash.token'),
	refresh_token: p('whiplash.token'),
	created_at: now() as Number,
	expires_in: 900000
}