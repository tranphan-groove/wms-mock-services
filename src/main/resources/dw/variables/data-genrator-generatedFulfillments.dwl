%dw 2.0
output application/json
---
payload.data map ((order, orderIndex) -> do {
    var uniqueVal = now() as Number
    var fulfillmentId = uniqueVal + orderIndex
    ---
    {
        "fulfillment_orders": [
            {
                "id": fulfillmentId,
                "shop_id": 48689217698,
                "order_id": order.order.id,
                "assigned_location_id": 55311958178,
                "request_status": "unsubmitted",
                "status": "open",
                "supported_actions": [
                    "create_fulfillment",
                    "hold",
                    "split"
                ],
                "destination": {
                    "id": 6380620775586,
                    "address1": "1/216 Station Road",
                    "address2": "",
                    "city": "Sunnybank",
                    "company": null,
                    "country": "Australia",
                    "email": "h.do@culturekings.com.au",
                    "first_name": "Ha",
                    "last_name": "Do",
                    "phone": "0456789090",
                    "province": "Queensland",
                    "zip": "4109"
                },
                "line_items": order.order.line_items map ((lineItem) -> {
                    "id": 13336948867234,
                    "shop_id": 48689217698,
                    "fulfillment_order_id": fulfillmentId,
                    "quantity": lineItem.quantity,
                    "line_item_id": lineItem.id,
                    "inventory_item_id": 44117762146466,
                    "fulfillable_quantity": 1,
                    "variant_id": 42015926714530
                }),
                "fulfill_at": "2023-08-14T13:00:00+10:00",
                "fulfill_by": null,
                "international_duties": null,
                "fulfillment_holds": [],
                "delivery_method": {
                    "id": 681639248034,
                    "method_type": "shipping",
                    "min_delivery_date_time": null,
                    "max_delivery_date_time": null
                },
                "created_at": "2023-08-14T13:35:03+10:00",
                "updated_at": "2023-08-14T13:35:03+10:00",
                "assigned_location": {
                    "address1": "39 Kerry Road",
                    "address2": "",
                    "city": "Archerfield",
                    "country_code": "AU",
                    "location_id": 55311958178,
                    "name": "Archerfield DC",
                    "phone": "",
                    "province": "QLD",
                    "zip": "4108"
                },
                "merchant_requests": []
            }
        ]
    }
})