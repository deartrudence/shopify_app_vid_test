class StoredProduct < ApplicationRecord
  belongs_to :shop
  has_many :product_images
  has_many :blocks

  scope :belongs_to_shop, -> shop_id { where(shop_id: shop_id) }
end
