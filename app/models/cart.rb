class Cart < ApplicationRecord
  has_many :cart_items, dependent: :nullify
  has_many :products, through: :cart_items
  belongs_to :user, optional: true

  def sub_total
    sum = 0
    cart_items.each do |cart_item|
      sum += cart_item.total_price
    end
    sum
  end
end
