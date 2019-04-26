class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage

  has_many :stored_products
end
