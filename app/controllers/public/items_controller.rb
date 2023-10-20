class Public::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).per(10)
      # ここ
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
   params.require(:items).permit(:genre_id,:name,:description,:image_id,:price)
  end

end
