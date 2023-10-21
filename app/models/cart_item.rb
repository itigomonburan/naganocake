class CartItem < ApplicationRecord
  
  belongs_to :customer
  belongs_to :item
  
  ## 小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end
  
  def with_tax_price
    (price * 1.1).floor
  end
end
