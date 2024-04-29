class Product < ApplicationRecord
  has_rich_text :description
  has_one_attached :picture

  validates_presence_of :name, :picture, :description
end
