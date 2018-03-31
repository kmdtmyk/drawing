json.extract! customer, :id, :name, :short_name, :display_order, :order_flag, :outsource_flag, :created_at, :updated_at
json.url customer_url(customer, format: :json)
