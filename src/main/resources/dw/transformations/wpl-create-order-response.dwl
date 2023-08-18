%dw 2.0
output application/json
fun countryName(code) = (
    if (code == 'US') 'United States'
    else if (code == 'NZ') 'New Zealand'
    else 'unknown'
)
var customerId = (now() as Number) + randomInt(500)
var packageId = (now() as Number) + randomInt(500)
---
{
    "id": vars.orderId,
    "customer_id": customerId,
    "order_batch_id": null,
    "quote_id": null,
    "warehouse_id": 24,
    "return_warehouse_id": 24,
    "shipping_method_id": payload.shipping_method_id,
    "estimated_shipping_method_id": null,
    "humanize_id": vars.orderId ++ '_' ++ payload.order_orig,
    "status": 100,
    "status_name": "Processing",
    "previous_status": 100,
    "order_orig": payload.order_orig,
    "level1_token": uuid(),
    "level2_token": uuid(),
    "workable_at": now(),
    "skip_street_date": false,
    "due_at": now(),
    "created_at": now(),
    "updated_at": now(),
    "meta_data": null,
    "customer_provided_label_carrier": null,
    "purchase_order": null,
    "order_type": payload.order_type,
    "email": payload.email,
    "address_verified": null,
    "items_updateable": true,
    "address_message": null,
    "shop_warehouse_ids": [],
    "shop_shipping_method_currency": payload.shop_shipping_method_currency,
    "shop_created_at": payload.shop_created_at,
    "shop_updated_at": null,
    "shop_shipping_method_text": payload.shop_shipping_method_text,
    "shop_shipping_method_price": payload.shop_shipping_method_price as String,
    "billing_company": null,
    "billing_address_1": payload.billing_address_1,
    "billing_address_2": payload.billing_address_2,
    "billing_address_3": null,
    "billing_city": payload.billing_city,
    "billing_state": payload.billing_state,
    "billing_zip": payload.billing_zip,
    "billing_country": payload.billing_country,
    "billing_phone": null,
    "billed": false,
    "billing_name": null,
    "first_name": payload.first_name,
    "last_name": payload.last_name,
    "full_name": payload.full_name,
    "shipping_name": payload.shipping_name,
    "shipping_company": payload.shipping_company,
    "shipping_address_1": payload.shipping_address_1,
    "shipping_address_2": payload.shipping_address_2,
    "shipping_city": payload.shipping_city,
    "shipping_state": payload.shipping_state,
    "shipping_zip": payload.shipping_zip,
    "shipping_country": countryName(payload.shipping_country),
    "shipping_country_iso2": payload.shipping_country,
    "shipping_phone": null,
    "requested_address": (payload.shipping_address_1 default payload.shipping_address_2 default '') ++ "\n" ++ (payload.shipping_city default "") ++ ", " ++ (payload.shipping_state default "") ++ " " ++ (payload.shipping_zip default "") ++ "\n" ++ countryName(payload.shipping_country),
    "residential": true,
    "expedited": false,
    "require_signature": false,
    "require_adult_signature": false,
    "saturday_delivery": false,
    "gift": false,
    "insure": false,
    "contains_alcohol": false,
    "customs_required": false,
    "incoterm": null,
    "shipping_carrier_facility": null,
    "shipping_hold_for_pickup": null,
    "ship_actual_cost": null,
    "shipped_on": null,
    "ship_notes": null,
    "shipping_confirmation_sent": false,
    "ship_3rdparty_cost": "0.0",
    "ship_3rdparty_account": null,
    "ship_3rdparty_zip": null,
    "ship_3rdparty_country": null,
    "public_note": null,
    "days_in_transit": 1,
    "days_in_transit_carrier_estimate": null,
    "req_insurance_value": null,
    "ship_method": "Whiplash Cheapest Rate",
    "packingslip_pdf_url": null,
    "cf_packingslip_pdf_url": null,
    "customs_vat_number": null,
    "customs_eori_number": null,
    "customs_ioss_number": null,
    "tracking": [],
    "tracking_links": [""],
    "approximate_delivery_date": null,
    "calculated_time_limit": 30,
    "within_return_time_limit": false,
    "return_name": null,
    "return_company": null,
    "return_address_1": null,
    "return_address_2": null,
    "return_city": null,
    "return_state": null,
    "return_country": null,
    "return_zip": null,
    "return_phone": null,
    "return_email": null,
    "return_address_verified": null,
    "return_time_limit": null,
    "is_workable": false,
    "is_gestating": true,
    "permissions_limited": false,
    "order_items": payload.order_items map ((orderItem) -> do {
        var itemMaster = (vars.itemMasters filter ((itemMaster) -> itemMaster.id as String == orderItem.item_id))[0]
        ---
        {
            "id": orderItem.item_id as Number,
            "order_id": vars.orderId,
            "customer_id": customerId,
            "item_id": orderItem.item_id as Number,
            "package_id": packageId,
            "quote_item_id": null,
            "sku": itemMaster.unified_model.sku,
            "description": itemMaster.unified_model.name,
            "quantity": orderItem.quantity,
            "price": orderItem.price as String,
            "created_at": now(),
            "updated_at": now(),
            "unshippable": false,
            "available": true,
            "packed": 0,
            "packaging": false,
            "wholesale_cost": null,
            "is_bundle": false,
            "retail_fee": null,
            "promo": false,
            "returnable": null,
            "currency": orderItem.currency,
            "wholesale_fee": null,
            "hazmat": false,
            "misc": null,
            "request_serial_number": false,
            "originator": {
                "id": (now() as Number) + randomInt(500),
                "originated_id": orderItem.item_id,
                "originated_type": "OrderItem",
                "shop_id": null,
                "provider": "api",
                "original_id": null,
                "group_id": null,
                "misc": null,
                "active": true,
                "integration_id": null,
                "last_notified_at": null,
                "last_notification_status": null,
                "distinct_originator_key": null,
                "created_at": now(),
                "updated_at": now(),
                "application_id": 87
            }
        }
    }),
    "originator": {
        "id": (now() as Number) + randomInt(500),
        "originated_id": vars.orderId,
        "originated_type": "Order",
        "shop_id": null,
        "provider": "api",
        "original_id": null,
        "group_id": null,
        "misc": null,
        "active": true,
        "integration_id": null,
        "last_notified_at": null,
        "last_notification_status": null,
        "distinct_originator_key": null,
        "created_at": now(),
        "updated_at": now(),
        "application_id": 87
    },
    "proto_originator_id": null,
    "packages": [{
        "id": packageId,
        "order_id": vars.orderId,
        "shipped_on": null,
        "ship_actual_cost": null,
        "actual_weight": null,
        "actual_width": null,
        "actual_height": null,
        "actual_length": null,
        "actual_dimensional_weight": null,
        "tracking": null,
        "tracking_link": "",
        "order_item_ids": payload.order_items.item_id map ((id) -> id as Number),
        "created_at": now(),
        "updated_at": now(),
        "ucc128": null,
        "ship_actual_currency": null,
        "vics_bill_of_lading": packageId,
        "manifest_id": null
    }],
    "shipping_method": {
        "id": 37,
        "carrier": "Whiplash",
        "service": "cheapest",
        "description": "Cheapest Rate",
        "name": "Whiplash Cheapest Rate",
        "international": false,
        "active": true,
        "flat_rate": false,
        "expedited": false,
        "trackable": true,
        "origins": ["US", "GB"],
        "extended_description": null,
        "created_at": "2014-11-19T15:53:32.000-05:00",
        "updated_at": "2015-08-03T16:23:10.000-04:00"
    },
    "serial_numbers": []
}