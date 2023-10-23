class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @cart_items = current_customer.cart_items
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def index
    @orders = current_customer.orders.page(params[:page]).order(created_at: :desc)
  end

  def confirm
      @order = Order.new(order_params)
      if params[:order][:select_address] == "0"#顧客の住所
        @order.name = current_customer.last_name + current_customer.first_name
        @order.address =  current_customer.address
        @order.post_code = current_customer.post_code
      elsif params[:order][:select_address] == "1" #登録した住所
        @address = Address.find(params[:order][:address_id])
        @order.post_code = @address.post_code
        @order.address = @address.address
        @order.name = @address.name
      elsif params[:order][:select_address] == "2"#新しい住所
        @order.post_code = params[:order][:post_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
        unless @order.validates_exclusion_of(:name, :address, :post_code, in: [nil, ""])
          # name, address, post_codeの値が空でないことを確認
          @addresses = current_customer.addresses
          render :new
        end
      else
      redirect_to new_order_path
      end
      @cart_items = current_customer.cart_items
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = (cart_item.item.price * 1.1).floor
      @order_detail.order_id = @order.id
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def complete
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :address , :post_code, :name, :payment_method, :status, :shipping_cost, :amount_billed )
  end

  def is_matching_login_customer
    order = Order.find(params[:id])
    customer = order.customer
    unless customer.id == current_customer.id
      redirect_to orders_path
    end
  end

  def cart_items_check
    if current_customer.cart_items.blank?
      flash[:notice] = "カートアイテムがありません。"
      flash[:color] = "text-danger"
      redirect_to root_path
    end
  end

end
