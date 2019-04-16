json.extract! stored_product, :id, :shopify_id, :shopify_title, :shopify_handle, :shopify_image_url, :lookbook_html , :shop_id, :created_at, :updated_at
json.url stored_product_url(stored_product, format: :json)
