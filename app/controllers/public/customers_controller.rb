class Public::CustomersController < ApplicationController
  
  def edit
    @customer = Customer.find(params[:id])
    if @customer == current_customer
      render "edit"
    else
      redirect_to posts_path
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @post = Post.find(params[:id])
    @posts = @customer.posts
  end

  def index
    @customers = Customer.all
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :introduce, :profile_image)
  end
  
end
