class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    if @post.save
      redirect_to post_path(@post), notice: "You have created book successfully."
    else
      @posts = Post.all
      render 'index'
    end
  end

  def index
  end

  def show
  end

  def edit
  end

  def post_params
    params.require(:post).permit(:name, :body)
  end

end
