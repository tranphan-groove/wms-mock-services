%dw 2.0
output application/json
var nowTimestamp = now()
var itemMaster = (vars.itemMasters filter ((itemMaster) -> itemMaster.source_system_id == payload.item_id as String))[0]
var warehouseAvailability = randomInt(40000) + 10000
---
{
    "item": {
        "id": payload.item_id,
        "sku": payload.sku,
        "title": payload.description,
        "description": payload.description,
        "full_description": payload.description,
        "original_location": null,
        "created_at": nowTimestamp,
        "updated_at": nowTimestamp,
        "customer_id": 200,
        "quantity": payload.quantity,
        "weight": "1.0",
        "available": true,
        "image_originator_url": "",
        "vendor": itemMaster.vendor,
        "scancode": itemMaster.unified_model.barcode,
        "price": "1.0",
        "media_mail": false,
        "packaging": false,
        "length": "1.0",
        "width": "1.0",
        "height": "1.0",
        "active": true,
        "wholesale_cost": null,
        "is_bundle": false,
        "packaging_type": null,
        "promo": false,
        "street_date": null,
        "category": null,
        "include_inbound_in_published": false,
        "returnable": null,
        "return_sku_match": null,
        "return_price_restricted": null,
        "request_serial_number": null,
        "currency": payload.currency,
        "tariff_number": null,
        "label_format": null,
        "notify_originator_inventory": null,
        "name": payload.description,
        "image_url": null,
        "hazmat": false,
        "hazmat_type": "",
        "misc": null,
        "ean": null,
        "lot_control": false,
        "expiration_period": null,
        "ship_strategy": 0,
        "velocity": 0,
        "case_quantity": null,
        "carton_quantity": null,
        "origin_country": null,
        "alcohol": false,
        "shippable_container": false,
        "replenishment_min": 0,
        "replenishment_target": null,
        "low_inventory_threshold": null,
        "published_quantity": payload.quantity,
    },
    "transaction": {
        "id": null,
        "description": null,
        "quantity": payload.quantity,
        "change": payload.quantity,
        "created_at": null,
        "updated_at": null,
        "item_id": payload.item_id,
        "order_id": null,
        "shipnotice_id": null
    },
    "warehouse_quantities": [
        {
        "id": 24,
        "name": "Ann Arbor",
        "shipping_address_1": "4657 Platt Road",
        "shipping_address_2": "",
        "shipping_city": "Ann Arbor",
        "shipping_state": "Michigan",
        "shipping_zip": "48108",
        "shipping_country": "United States",
        "shipping_country_iso2": "US",
        "email": "annarbor@whiplashmerch.com",
        "latitude": 42.2206,
        "longitude": -83.6989,
        "quantity": randomInt(40) + 10,
        "projected_quantity": warehouseAvailability,
        "sellable_quantity": warehouseAvailability
        }
    ],
    "event_name": "item.inventory_changed"
}