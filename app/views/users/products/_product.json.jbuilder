json.extract! product, :id, :product_name, :product_detail, :price, :quantity, :created_at, :updated_at
json.url product_url(product, format: :json)
