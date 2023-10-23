class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_waiting: 0, payment_confirmation: 1, in_production: 2, preparing_delivery: 3, delivered: 4 }

  validates :amount_billed, presence:true
  validates :shipping_cost, presence:true
  validates :payment_method, presence:true
  validates :post_code, presence:true, numericality: {only_integer: true}
  validates :address, presence:true
  validates :name, presence:true

end
