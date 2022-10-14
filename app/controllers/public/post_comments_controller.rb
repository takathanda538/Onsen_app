class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    redirect_back(fallback_location: root_path)
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
      redirect_to post_path(@post), notice: "コメントを編集しました"
    else
      flash.now[:alert] = "編集に失敗しました"
      render 'edit'
    end
  end
  
  def destroy
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    flash[:alert] = "コメントを削除しました"
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
