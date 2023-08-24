%dw 2.0
output application/json
import * from dw::util::Timer
import * from dw::util::Values
var packFee = (random() * 100) as String {format: '##.##'}
var pickFee = (random() * 100) as String {format: '##.##'}
---
{
    "event_name": "order.shipped",
    "fees": {
        "currency": payload.shop_shipping_method_currency,
        "pack": packFee,
        "packaging": "0.0",
        "pick": pickFee,
        "postage": "0.0",
        "total": (packFee + pickFee) as String {format: '##.##'}
    },
    "order": 
    (
        payload update {
            case .order_batch_id -> currentMilliseconds()
            case .address_verified -> true
            case .ship_actual_cost -> "0.0"
            case .packingslip_pdf_url -> ""
            case .shipped_on -> now()
            case .packages -> (
                payload.packages map ((package) -> (
                    package update {
                        case .actual_weight -> (random() * 10000) as String {format: '##.#'}
                        case .actual_width -> (random() * 100) as String {format: '##.#'}
                        case .actual_height -> (random() * 1000) as String {format: '##.#'}
                        case .actual_length -> (random() * 100) as String {format: '##.#'}
                        case .actual_dimensional_weight -> (random() * 1000)
                    }
                ))
            )
        }
    ),
    "tracking_details": "[]"
}