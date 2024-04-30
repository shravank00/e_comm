class Order < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  validates_presence_of :total_price
end
