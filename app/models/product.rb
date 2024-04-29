class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :picture
  has_many :cart_items, dependent: :destroy

  validates_presence_of :name, :picture, :description, :price
end
