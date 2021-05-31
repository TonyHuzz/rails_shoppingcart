class Product < ApplicationRecord
  has_many :cart_items
  has_many :order_items

  belongs_to :subcategory
  mount_uploader :image_url, ImageUploader

  validates :name, :description, presence: true
end
