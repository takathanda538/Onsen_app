class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @post = Post.find(params[:id])
    @post_comments = PostComment.all
  end
  
  def index
    @posts = Post.all
  end
  
  def edit
    @post = Post.find(params[:id])
    if admin_signed_in?
      render "edit"
    else
      redirect_to posts_path
    end
  end
  
  def update
    @post = Post.find(params[:id])
    @post.score = Language.get_data(post_params[:body])
    if @post.update(post_params)
      @post.post_images.each do |image|
         tags = Vision.get_image_data(image)
         tags.each do |tag|
           @post.tags.create(name: tag)
         end
       end
      redirect_to admin_post_path(@post), notice: "投稿を編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "投稿を消去しました"
  end
  
  private

  def post_params
    params.require(:post).permit(:name,:ride_area, :title, :body, post_images: [] )
  end
  
end
