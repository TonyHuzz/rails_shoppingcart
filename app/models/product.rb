class Product < ApplicationRecord
  has_many :cart_items
  belongs_to :subcategory
  mount_uploader :image_url, ImageUploader
end
