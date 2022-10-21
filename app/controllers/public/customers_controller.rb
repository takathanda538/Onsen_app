class Public::CustomersController < ApplicationController
  
  before_action :set_customer, only: [:follows, :followers,:likes]
  before_action :ensure_guest_customer, only: [:edit]
  
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
    
    unless admin_signed_in?
      @current_entry = Entry.where(customer_id: current_customer.id)
      @another_entry = Entry.where(customer_id: @customer.id)
      unless @customer.id == current_customer.id
        @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id
              @is_room = true
              @room_id = current.room_id
            end
          end
        end
        unless @is_room
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def index
    @customers = Customer.all
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer.id), notice: "更新に成功しました"
    else
      @customer = Customer.find(params[:id])
      render "edit", notice: "更新に失敗しました"
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
  
  def likes
    likes = Like.where(customer_id: @customer.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :introduce, :profile_image)
  end
  
  def set_customer
    @customer = Customer.find(params[:id])
  end
  
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    if @customer.name == "guestuser"
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  

  
end