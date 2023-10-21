class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:top]

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を行いました。"
    redirect_to root_path
  end
end
