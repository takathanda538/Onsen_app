class AddReplyCommentToPostComment < ActiveRecord::Migration[6.1]
  def change
    add_column :post_comments,:reply_comment,:string
  end
end
