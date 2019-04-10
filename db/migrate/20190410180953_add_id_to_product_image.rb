class AddIdToProductImage < ActiveRecord::Migration[5.1]
  def change
    add_column :product_images, :shopify_id, :string
  end
end
