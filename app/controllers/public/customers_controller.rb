class Public::CustomersController < ApplicationController
  
  def edit
    @customer = Customer.find(params[:id])
    if @user == current_user
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
  
  private

  def customer_params
    params.require(:customer).permit(:name, :introduce, :profile_image)
  end
  
end
