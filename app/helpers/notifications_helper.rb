module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_item = link_to 'あなたの投稿', post_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.post_comment_id
    # notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "があなたをフォローしました"
      when "favorite" then
        tag.a(notification.visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;") + "にいいねしました"
      when "comment" then
        @comment = PostComment.find_by(id: @visiter_comment)
        tag.a(@visiter.name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿' , href:post_path(notification.post_id) , style:"font-weight: bold;") + "にコメントしました"
    end
  end
end
