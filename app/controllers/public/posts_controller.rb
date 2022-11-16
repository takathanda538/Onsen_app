class Public::PostsController < ApplicationController
  before_action :authenticate_customer!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    @post.score = Language.get_data(post_params[:body])  #この行を追加
    if @post.save
        @post.post_images.each do |image|
          tags = Vision.get_image_data(image)    
          tags.each do |tag|
            @post.tags.create(name: tag)
          end
        end
      redirect_to post_path(@post), notice: "投稿に成功しました"
    else
      render 'new', notice: "投稿に失敗しました"
    end
  end

  def index
    @post = Post.new
    @posts = Post.page(params[:page]).per(5).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(20).order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.score = Language.get_data(post_params[:body]) 
    @post.tags.destroy_all
    if @post.update(post_params)
      @post.post_images.each do |image|
         tags = Vision.get_image_data(image)    
         tags.each do |tag|
           @post.tags.create(name: tag)
         end
       end
      redirect_to post_path(@post), notice: "投稿を編集しました"
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を消去しました"
  end

  def search
    if params[:name].present?
      @results =Post.where("name LIKE ?", "%#{params[:name]}%").page(params[:page]).per(5).order('created_at DESC')
    else
      @results = Post.where(ride_area: params[:ride_area]).page(params[:page]).per(5).order('created_at DESC')
    end
  end
  private

  def post_params
    params.require(:post).permit(:name,:ride_area, :title, :body, post_images: [] )
  end

end
