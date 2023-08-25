%dw 2.0
output application/csv quoteValues=true, escape=""
import modules::AddQuotes
---
((vars.generatedAUOrders.data default []) map ((item, index) -> {
    id: item.order.id,
    order: AddQuotes::execute(item.order),
    header: vars.generatedAUOrders.header
})) ++
((vars.generatedUSOrders.data default []) map ((item, index) -> {
    id: item.order.id,
    order: AddQuotes::execute(item.order),
    header: vars.generatedUSOrders.header
}))