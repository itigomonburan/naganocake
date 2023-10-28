class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      order = @order_detail.order
      if @order_detail.making_status == "in_production"
        order.update(status: "in_production")
      end
      if order.order_details.all? { |detail| detail.making_status == "production_complete" }
      order.update(status: "preparing_delivery")
      end
    redirect_to request.referer, notice: '制作ステータスを更新しました。'
    end
  end


  private
  def order_detail_params
      params.require(:order_detail).permit(:item_id, :order_id, :amount, :making_status, :price)
  end
end