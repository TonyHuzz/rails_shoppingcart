class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: [ :not_paid, :paid, :cancelled ]


  def amount
    @amount = 0

    order_items.each do |item|
      @amount += item.quantity * (item.price)
    end

    return @amount
  end
end
