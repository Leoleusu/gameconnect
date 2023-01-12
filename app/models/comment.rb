class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :notifications, dependent: :destroy

  #通知作成メソッド
  def create_notification_comment(current_user)
    #自分以外のコメントをした人全てを取得して通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id["user_id"])
    end
    #誰もコメントをしていない場合は投稿者に通知を送る
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, receiver_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      receiver_id: receiver_id,
      action: "comment"
    )
    #自分へのコメントは通知をこないようにする
    if notification.sender_id == notification.receiver_id
      notification.is_check = true
    end
    notification.save if notification.valid?
  end

end
