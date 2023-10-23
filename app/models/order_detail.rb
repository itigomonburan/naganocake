class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  validates :price_including_tax, presence:true
  validates :amount, presence:true

  enum making_status: { start_not_posssible: 0, production_pending: 1, in_production: 2, production_complete: 3 }
end
