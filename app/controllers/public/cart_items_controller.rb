class Public::CartItemsController < ApplicationController

  def create
    @item = Item.find(params[:item_id])
  end

end
