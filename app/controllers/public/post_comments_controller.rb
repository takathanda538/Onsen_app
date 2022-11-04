class Public::PostCommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @post_comments = @post.post_comments.order(created_at: :desc)
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.customer_id = current_customer.id
    if @post_comment.save
      @post.create_notification_comment(current_customer, @post_comment.id)
    # render :index
    else
      redirect_back(fallback_location: root_path, notice: '投稿に失敗しました。')
    end
  end

  def index
  end

  def show
  end
  

  def edit
    @post_comment = PostComment.find(params[:id])
    @post = Post.find(params[:post_id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    if @post_comment.update(post_comment_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post = @post_comment.post
    @post_comments = @post.post_comments
    @post_comment.destroy
    # redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
