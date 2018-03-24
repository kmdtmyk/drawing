json.extract! drawing, :id, :part_number, :order_date, :estimated_price, :difficulty, :created_at, :updated_at
json.url drawing_url(drawing, format: :json)
