class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  enum status: [ :not_paid, :paid, :cancelled ]

  validates :user_name, :user_address, presence: true
  validates :user_phone, format: { with: /\A\d{10}\z/, message: "only allows Taiwanese phone number(10 digits)" }
  validates :status, inclusion: { in: %w(not_paid paid cancelled) }

  def amount
    @amount = 0

    order_items.each do |item|
      @amount += item.quantity * (item.price)
    end

    return @amount
  end
end
