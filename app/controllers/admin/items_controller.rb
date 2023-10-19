class Admin::ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_items_path, notice: "登録しました。"
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :price, :is_active, :genre_id)
  end

end
