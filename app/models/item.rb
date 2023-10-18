class Item < ApplicationRecord

  has_one_attached :image
  validates :image, presence:true
  validates :name, presence:true, uniqueness: true
  validates :description, presence:true
  validates :price_without_tax, presence:true, numericality: {only_integer: true, greater_than_or_equal_to: 1}

  belongs_to :genle
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
end
