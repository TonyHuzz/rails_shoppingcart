class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :products

  validates :name, :description, presence: true

  def name_with_category
    "#{category.try(:name)} / #{name}"
  end
end
