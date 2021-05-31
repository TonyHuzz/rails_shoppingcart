class Product < ApplicationRecord
  has_many :cart_items
  has_many :order_items

  belongs_to :subcategory
  mount_uploader :image_url, ImageUploader

  validates :name, :description, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
