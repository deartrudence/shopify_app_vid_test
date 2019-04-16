class AddHandleToStoredProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :stored_products, :shopify_handle, :string
  end
end
