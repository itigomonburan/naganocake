class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def show
  end

  def index
  end

  def confirm
    @cart_items = CartItem.where(customers_id: current_customer.id)
    @shipping_fee = 800 #送料は800円で固定
    @selected_pay_method = params[:order][:pey_method]
  end

  def complite
  end

end
