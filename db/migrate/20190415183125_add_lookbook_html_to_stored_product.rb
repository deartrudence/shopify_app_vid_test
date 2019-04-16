class AddLookbookHtmlToStoredProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :stored_products, :lookbook_html, :text
  end
end
