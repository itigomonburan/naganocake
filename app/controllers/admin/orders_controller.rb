class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
  end

  def update
    @status = Order.find(params[:id])
    if @status.update(order_params)
      if @status.status == "payment_confirmation"
      @status.order_details.update(making_status: "production_pending")
      end
    redirect_to request.referer, notice: '注文ステータスを更新しました。'
   
    end
  end

  private
  def order_params
      params.require(:order).permit(:address, :post_code, :name, :payment_method, :status, :shipping_cost, :amount_bill)
  end
end
