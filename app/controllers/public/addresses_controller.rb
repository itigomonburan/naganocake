class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!, except: [:top]
  def index
    @address = Address.new
    @addresses = Address.all.where(customer_id: current_customer.id)
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "登録されました"
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice]="変更しました"
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

  private
  def address_params
    params.require(:address).permit(:post_code, :address,:name)
  end
end
