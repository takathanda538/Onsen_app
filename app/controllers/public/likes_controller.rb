class Public::LikesController < ApplicationController
  def index
  end

  def create
    @post = Post.find(params[:post_id])
    like = current_customer.likes.new(post_id: @post.id)
    like.save
    render :toggle
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_customer.likes.find_by(post_id: @post.id)
    like.destroy
    render :toggle
  end
end
