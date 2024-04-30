class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :order, optional: true
  def total_price
    quantity * product.price
  end
end
