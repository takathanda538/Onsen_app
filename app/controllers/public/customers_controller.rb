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
    @posts = @customer.posts
    @following_customers = @customer.following_customer
    @follower_customers = @customer.follower_customer
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
  
  def follows
    customer = Customer.find(params[:id])
    @customers = customer.following_customer
  end
  
  def followers
    customer = Customer.find(params[:id])
    @customers = customer.follower_customer
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :introduce, :profile_image)
  end
  
end
