class Public::CartItemsController < ApplicationController

  before_action :authenticate_customer!
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to request.referer, notice: '数量を変更しました。'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer, notice: '商品を削除しました。'
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to request.referer, notice: 'カートを空にしました。'
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    existing_cart_item = CartItem.find_by(item_id: @cart_item.item_id, customer_id: current_customer.id)
    if  existing_cart_item.nil?
      @cart_item.save
    else
      new_amount = existing_cart_item.amount + @cart_item.amount
      existing_cart_item.update(amount: new_amount)
    end
    redirect_to cart_items_path, notice: "カートに商品が入りました"
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end
end

