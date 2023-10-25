class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
  end

  def update
    @status = Order.find(params[:id])
    @status.update(order_params)
    redirect_to request.referer, notice: '注文ステータスを更新しました。'
  end

  private
  def order_params
      params.require(:order).permit(:address, :post_code, :name, :payment_method, :status, :shipping_cost, :amount_bill)
  end
end
