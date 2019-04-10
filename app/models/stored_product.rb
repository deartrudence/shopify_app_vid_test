class StoredProduct < ApplicationRecord
  belongs_to :shop
  has_many :product_images
end
