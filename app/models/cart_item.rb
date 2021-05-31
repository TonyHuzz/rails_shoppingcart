class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def product_name
    product.try(:name) || ""
  end

  def product_price
    @price = product.try(:price)

    if !@price  || @price < 0
      @price = 0
    end

    return  @price
  end
end
