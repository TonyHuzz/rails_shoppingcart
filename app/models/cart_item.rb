class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

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
