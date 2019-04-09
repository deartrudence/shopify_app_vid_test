class AddLanguageToShop < ActiveRecord::Migration[5.1]
  def change
    add_column :shops, :language, :string, default: 'en'
  end
end
