class CreateStoredProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :stored_products do |t|
      t.string :shopify_id
      t.string :shopify_title
      t.string :shopify_image_url
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
