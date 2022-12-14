class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @customers = Customer.all.order(id: "DESC")
  end

  def show
    @customer = Customer.find(params[:id])
    @posts = @customer.posts.order(id: "DESC")
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      flash[:notice] = "入力内容を確認してください"
      render "edit"
    end
  end

  def search
    @customers = Customer.where("name LIKE ?" , "%#{params[:name]}%")
  end

  private

  def customer_params
    params.require(:customer).permit(
      :name,
      :email,
      :is_deleted
      )
  end

end
