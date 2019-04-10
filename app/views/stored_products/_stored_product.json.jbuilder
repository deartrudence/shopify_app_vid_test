json.extract! stored_product, :id, :shopify_id, :shopify_title, :shopify_image_url, :shop_id, :created_at, :updated_at
json.url stored_product_url(stored_product, format: :json)
