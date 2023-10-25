class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!
  def update
    @status = OrderDetail.find(params[:id])
    @status.update(order_detail_params)
    redirect_to request.referer, notice: '制作ステータスを更新しました。'
  end

  private
  def order_detail_params
      params.require(:order_detail).permit(:item_id, :order_id, :amount, :making_status, :price)
  end
end
