%dw 2.0
import * from dw::core::Arrays
output application/json
---
(0 to (vars.orderQuantity - 1)) map ((orderIndex) -> do {
    var uniqueVal = now() as Number
    var orderId = uniqueVal + randomInt(1000)
    var transactionId = uniqueVal + randomInt(1000)
    var currency = 'USD'

    var lineItems = do {
        var itemMasterIndexes = slice((0 to (sizeOf(vars.itemMasters) - 1)) orderBy random(), 0, vars.itemQuantity)
        ---
        itemMasterIndexes map ((itemMasterIndex, index) -> do {
            var taxTypes = if (currency == 'AUD') [
                {
                    "rate": 0.1,
                    "title": "AUSTRALIA GST"
                }
            ] else [
                {
                    "rate": 0.046,
                    "title": "NVSTATETAX"
                },
                {
                    "rate": 0.025,
                    "title": "NVCOUNTYTAX"
                }
            ]
            var itemId = uniqueVal + randomInt(1000)
            var item = vars.itemMasters[itemMasterIndex]
            var preTaxPrice = (item.unified_model.prices filter ((price) -> price.currency == currency))[0].value
            var tax = preTaxPrice * sum(taxTypes.rate)
            var price = if (currency == 'AUD') (preTaxPrice + tax) else preTaxPrice
            ---
            {
                "id": itemId,
                "admin_graphql_api_id": "gid://shopify/LineItem/" ++ itemId,
                "destination_location": {
                    "id": 3585181188273,
                    "country_code": "US",
                    "province_code": "NV",
                    "name": "TramLy(NV)",
                    "address1": "1075AllenRd",
                    "address2": "",
                    "city": "BattleMountain",
                    "zip": "89820"
                },
                "fulfillable_quantity": 1,
                "fulfillment_service": "manual",
                "fulfillment_status": null,
                "gift_card": false,
                "grams": 0,
                "name": item.unified_model.name,
                "origin_location": {
                    "id": 3346318491825,
                    "country_code": "US",
                    "province_code": "CA",
                    "name": "CultureKingsUATUS",
                    "address1": "5116ChinoHillsParkway",
                    "address2": "Bldg.16",
                    "city": "Chino",
                    "zip": "91710"
                },
                "pre_tax_price": preTaxPrice as String,
                "pre_tax_price_set": {
                    "shop_money": {
                        "amount": preTaxPrice as String,
                        "currency_code": currency
                    },
                    "presentment_money": {
                        "amount": preTaxPrice as String,
                        "currency_code": currency
                    }
                },
                "price": price as String,
                "price_set": {
                    "shop_money": {
                        "amount": price as String,
                        "currency_code": currency
                    },
                    "presentment_money": {
                        "amount": price as String,
                        "currency_code": currency
                    }
                },
                "product_exists": true,
                "product_id": 7193724879025,
                "properties": [
                
                ],
                "quantity": 1,
                "requires_shipping": true,
                "sku": item.sku,
                "taxable": true,
                "title": item.unified_model.name,
                "total_discount": "0.00",
                "total_discount_set": {
                    "shop_money": {
                        "amount": "0.00",
                        "currency_code": currency
                    },
                    "presentment_money": {
                        "amount": "0.00",
                        "currency_code": currency
                    }
                },
                "variant_id": 41682062540977,
                "variant_inventory_management": "shopify",
                "variant_title": "XL",
                "vendor": "MYCHEMICALROMANCE",
                "tax_lines": taxTypes map ((taxType) -> {
                    "channel_liable": false,
                    "price": (preTaxPrice * taxType.rate) as String,
                    "price_set": {
                        "shop_money": {
                            "amount": (preTaxPrice * taxType.rate) as String,
                            "currency_code": currency
                        },
                        "presentment_money": {
                            "amount": (preTaxPrice * taxType.rate) as String,
                            "currency_code": currency
                        }
                    },
                    "rate": taxType.rate,
                    "title": taxType.title
                }),
                "duties": [
                
                ],
                "discount_allocations": [
                
                ]
            }
        })
    }
    var subtotalPrice = sum(lineItems.pre_tax_price map ((price) -> price as Number)) as String
    var totalPrice = sum(lineItems.price map ((price) -> price as Number)) as String
    var totalTax = sum((flatten(lineItems.tax_lines).price) map ((price) -> price as Number)) as String
    ---
    {
        "order": {
            "id": orderId,
            "admin_graphql_api_id": "gid://shopify/Order/" ++ orderId,
            "app_id": 1354745,
            "browser_ip": null,
            "buyer_accepts_marketing": false,
            "cancel_reason": null,
            "cancelled_at": null,
            "cart_token": null,
            "checkout_id": 929174487220401,
            "checkout_token": "424dd3b1e33660f75b5f30a81f97f532",
            "client_details": {
            "accept_language": null,
            "browser_height": null,
            "browser_ip": null,
            "browser_width": null,
            "session_hash": null,
            "user_agent": null
            },
            "closed_at": null,
            "confirmed": true,
            "contact_email": "t.ly@cultureking.com.au",
            "created_at": now(),
            "currency": currency,
            "current_subtotal_price": subtotalPrice,
            "current_subtotal_price_set": {
            "shop_money": {
                "amount": subtotalPrice,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": subtotalPrice,
                "currency_code": currency
            }
            },
            "current_total_discounts": "0.00",
            "current_total_discounts_set": {
            "shop_money": {
                "amount": "0.00",
                "currency_code": currency
            },
            "presentment_money": {
                "amount": "0.00",
                "currency_code": currency
            }
            },
            "current_total_duties_set": null,
            "current_total_price": totalPrice,
            "current_total_price_set": {
            "shop_money": {
                "amount": totalPrice,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": totalPrice,
                "currency_code": currency
            }
            },
            "current_total_tax": totalTax,
            "current_total_tax_set": {
            "shop_money": {
                "amount": totalTax,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": totalTax,
                "currency_code": currency
            }
            },
            "customer_locale": "en",
            "device_id": null,
            "discount_codes": [
            
            ],
            "email": "t.ly@cultureking.com.au",
            "estimated_taxes": false,
            "financial_status": "paid",
            "fulfillment_status": null,
            "gateway": "manual",
            "landing_site": null,
            "landing_site_ref": null,
            "location_id": null,
            "name": "CKBLZ10001",
            "note": null,
            "note_attributes": [
            
            ],
            "number": 10001,
            "order_number": 10001,
            "order_status_url": "",
            "original_total_duties_set": null,
            "payment_gateway_names": [
            "manual"
            ],
            "phone": null,
            "presentment_currency": currency,
            "processed_at": "2023-07-10T00:18:35-07:00",
            "processing_method": "manual",
            "reference": null,
            "referring_site": null,
            "source_identifier": null,
            "source_name": "shopify_draft_order",
            "source_url": null,
            "subtotal_price": subtotalPrice,
            "subtotal_price_set": {
            "shop_money": {
                "amount": subtotalPrice,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": subtotalPrice,
                "currency_code": currency
            }
            },
            "tags": "",
            "tax_lines": [
            {
                "price": "5.10",
                "rate": 0.025,
                "title": "NVCOUNTYTAX",
                "price_set": {
                "shop_money": {
                    "amount": "5.10",
                    "currency_code": currency
                },
                "presentment_money": {
                    "amount": "5.10",
                    "currency_code": currency
                }
                },
                "channel_liable": false
            },
            {
                "price": "9.38",
                "rate": 0.046,
                "title": "NVSTATETAX",
                "price_set": {
                "shop_money": {
                    "amount": "9.38",
                    "currency_code": currency
                },
                "presentment_money": {
                    "amount": "9.38",
                    "currency_code": currency
                }
                },
                "channel_liable": false
            }
            ],
            "taxes_included": false,
            "test": false,
            "token": "19a573a9f02b29b32d0e7f32e0b1ad3a",
            "total_discounts": "0.00",
            "total_discounts_set": {
            "shop_money": {
                "amount": "0.00",
                "currency_code": currency
            },
            "presentment_money": {
                "amount": "0.00",
                "currency_code": currency
            }
            },
            "total_line_items_price": subtotalPrice,
            "total_line_items_price_set": {
            "shop_money": {
                "amount": subtotalPrice,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": subtotalPrice,
                "currency_code": currency
            }
            },
            "total_outstanding": "0.00",
            "total_price": totalPrice,
            "total_price_set": {
            "shop_money": {
                "amount": totalPrice,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": totalPrice,
                "currency_code": currency
            }
            },
            "total_price_usd": totalPrice,
            "total_shipping_price_set": {
            "shop_money": {
                "amount": "0.00",
                "currency_code": currency
            },
            "presentment_money": {
                "amount": "0.00",
                "currency_code": currency
            }
            },
            "total_tax": totalTax,
            "total_tax_set": {
            "shop_money": {
                "amount": totalTax,
                "currency_code": currency
            },
            "presentment_money": {
                "amount": totalTax,
                "currency_code": currency
            }
            },
            "total_tip_received": "0.00",
            "total_weight": 0,
            "updated_at": "2023-07-10T00:18:36-07:00",
            "user_id": 79872393393,
            "billing_address": {
            "first_name": "Tram",
            "address1": "1075AllenRd",
            "phone": "+17752251588",
            "city": "BattleMountain",
            "zip": "89820",
            "province": "Nevada",
            "country": "UnitedStates",
            "last_name": "Ly(NV)",
            "address2": "",
            "company": "",
            "latitude": 40.6565435,
            "longitude": -116.9904045,
            "name": "TramLy(NV)",
            "country_code": "US",
            "province_code": "NV"
            },
            "customer": {
            "id": 6409519300785,
            "email": "t.ly@cultureking.com.au",
            "accepts_marketing": false,
            "created_at": "2023-02-16T20:28:54-08:00",
            "updated_at": "2023-07-09T22:59:43-07:00",
            "first_name": "Tram",
            "last_name": "Ly(NV)",
            "state": "disabled",
            "note": null,
            "verified_email": true,
            "multipass_identifier": null,
            "tax_exempt": false,
            "phone": null,
            "email_marketing_consent": {
                "state": "not_subscribed",
                "opt_in_level": "single_opt_in",
                "consent_updated_at": null
            },
            "sms_marketing_consent": null,
            "tags": "",
            "currency": currency,
            "accepts_marketing_updated_at": "2023-02-16T20:28:54-08:00",
            "marketing_opt_in_level": null,
            "tax_exemptions": [
                
            ],
            "admin_graphql_api_id": "gid://shopify/Customer/6409519300785",
            "default_address": {
                "id": 7767337959601,
                "customer_id": 6409519300785,
                "first_name": "Tram",
                "last_name": "Ly(NV)",
                "company": "",
                "address1": "1075AllenRd",
                "address2": "",
                "city": "BattleMountain",
                "province": "Nevada",
                "country": "UnitedStates",
                "zip": "89820",
                "phone": "+17752251588",
                "name": "TramLy(NV)",
                "province_code": "NV",
                "country_code": "US",
                "country_name": "UnitedStates",
                "default": true
            }
            },
            "discount_applications": [
            
            ],
            "fulfillments": [
            
            ],
            "line_items": lineItems,
            "payment_terms": null,
            "refunds": [
            
            ],
            "shipping_address": {
            "first_name": "Tram",
            "address1": "1075AllenRd",
            "phone": "+17752251588",
            "city": "BattleMountain",
            "zip": "89820",
            "province": "Nevada",
            "country": "UnitedStates",
            "last_name": "Ly(NV)",
            "address2": "",
            "company": "",
            "latitude": 40.6565435,
            "longitude": -116.9904045,
            "name": "TramLy(NV)",
            "country_code": "US",
            "province_code": "NV"
            },
            "shipping_lines": [
            
            ],
            "transactions": [
            {
                "id": transactionId,
                "admin_graphql_api_id": "gid://shopify/OrderTransaction/" ++ transactionId,
                "amount": totalPrice,
                "authorization": "pi_3NYglcEXTnHX5Jzi0dTUGnI4",
                "created_at": now(),
                "currency": currency,
                "device_id": null,
                "error_code": null,
                "gateway": "manual",
                "kind": "sale",
                "location_id": null,
                "message": "Marked the manual payment as received",
                "order_id": orderId,
                "parent_id": null,
                "payment_id": "c24832194281634.1",
                "processed_at": now(),
                "receipt": {
                "id": "pi_3NYglcEXTnHX5Jzi0dTUGnI4",
                "object": "payment_intent",
                "amount": totalPrice * 100,
                "amount_capturable": totalPrice * 100,
                "amount_received": 0,
                "canceled_at": null,
                "cancellation_reason": null,
                "capture_method": "manual",
                "charges": {
                    "object": "list",
                    "data": [
                    {
                        "id": "ch_3NYglcEXTnHX5Jzi0v5YtOpn",
                        "object": "charge",
                        "amount": totalPrice * 100,
                        "application_fee": null,
                        "balance_transaction": null,
                        "captured": false,
                        "created": now() as Number,
                        "currency": "aud",
                        "failure_code": null,
                        "failure_message": null,
                        "fraud_details": {
                        
                        },
                        "livemode": false,
                        "metadata": {
                        "email": "t.ly@culturekings.com.au",
                        "manual_entry": "true",
                        "order_id": "c24832194281634.1",
                        "order_transaction_id": "6571915051170",
                        "payments_charge_id": "2383543894178",
                        "shop_id": "48689217698",
                        "shop_name": "CultureKingsUAT"
                        },
                        "outcome": {
                        "network_status": "approved_by_network",
                        "reason": null,
                        "risk_level": "normal",
                        "risk_score": 31,
                        "seller_message": "Paymentcomplete.",
                        "type": "authorized"
                        },
                        "paid": true,
                        "payment_intent": "pi_3NYglcEXTnHX5Jzi0dTUGnI4",
                        "payment_method": "pm_1NYglcEXTnHX5JziYlNdPrYI",
                        "payment_method_details": {
                        "card": {
                            "brand": "visa",
                            "capture_before": 1692931860,
                            "checks": {
                            "address_line1_check": "pass",
                            "address_postal_code_check": "pass",
                            "cvc_check": "pass"
                            },
                            "country": "US",
                            "description": "VisaClassic",
                            "ds_transaction_id": null,
                            "exp_month": 3,
                            "exp_year": 2030,
                            "fingerprint": "DmRDunvaPMAloFGB",
                            "funding": "credit",
                            "iin": "424242",
                            "installments": null,
                            "issuer": "StripePaymentsUKLimited",
                            "last4": "4242",
                            "mandate": null,
                            "moto": true,
                            "network": "visa",
                            "network_token": {
                            "used": false
                            },
                            "network_transaction_id": "105103107701011",
                            "payment_account_reference": "xR4eIL3CZCjH9hMkhqeysHPkE5Zxs",
                            "three_d_secure": null,
                            "wallet": null
                        },
                        "type": "card"
                        },
                        "refunded": false,
                        "source": null,
                        "status": "succeeded",
                        "mit_params": {
                        "network_transaction_id": "105103107701011"
                        }
                    }
                    ],
                    "has_more": false,
                    "total_count": 1,
                    "url": "/v1/charges?payment_intent=pi_3NYglcEXTnHX5Jzi0dTUGnI4"
                },
                "confirmation_method": "manual",
                "created": now() as Number,
                "currency": "aud",
                "last_payment_error": null,
                "livemode": false,
                "metadata": {
                    "email": "t.ly@culturekings.com.au",
                    "manual_entry": "true",
                    "order_id": "c24832194281634.1",
                    "order_transaction_id": "6571915051170",
                    "payments_charge_id": "2383543894178",
                    "shop_id": "48689217698",
                    "shop_name": "CultureKingsUAT"
                },
                "next_action": null,
                "payment_method": "pm_1NYglcEXTnHX5JziYlNdPrYI",
                "payment_method_types": [
                    "card"
                ],
                "source": null,
                "status": "requires_capture"
                },
                "source_name": "shopify_draft_order",
                "status": "success",
                "test": true,
                "user_id": null,
                "payment_details": {
                "credit_card_bin": "424242",
                "avs_result_code": "Y",
                "cvv_result_code": "M",
                "credit_card_number": "••••••••••••4242",
                "credit_card_company": "Visa",
                "buyer_action_info": null,
                "credit_card_name": "t",
                "credit_card_wallet": null,
                "credit_card_expiration_month": 3,
                "credit_card_expiration_year": 2030
                }
            }
            ]
        }
    }
})