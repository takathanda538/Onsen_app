module Public::NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @post_comment = nil
    @visitor_comment = notification.post_comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: customer_path(@visitor)) + 'があなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.name, href: customer_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にいいねしました'
    when 'comment' then
      @post_comment = PostComment.find_by(id: @visitor_comment)
      @post_title = @post_comment.post.title
      tag.a(@visitor.name, href: customer_path(@visitor)) + 'が' + tag.a("#{@post_title}", href: post_path(notification.post_id)) + 'にコメントしました'
    end
  end
end
