%dw 2.0
output application/csv quoteValues=true, escape=""
import modules::AddQuotes
---
payload.data map ((item, index) -> {
    id: item.order.id,
    order: AddQuotes::execute(item.order)
})