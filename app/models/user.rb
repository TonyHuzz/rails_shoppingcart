class User < ApplicationRecord
  has_many :carts

  before_save :salted
  after_save :add_carts

  def salted
    if self.id.blank?
      self.password = "aaaaa" + self.password
    end
  end

  def add_carts
    if self.carts.blank?
      Cart.buy_now.create(user: self )
      Cart.buy_next_time.create(user: self )
    end
  end

end
