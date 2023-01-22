class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 1_150 }

  #通知作成メソッド
  def create_notification_comment(current_user)
    #自分以外のコメントをした人全てを取得して通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: post_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, temp_id["user_id"])
    end
    #投稿主にも通知を送る
    save_notification_comment(current_user, post.user_id)
  end

  def save_notification_comment(current_user, receiver_id)
    notification = current_user.active_notifications.new(
      post_id: post_id,
      comment_id: id,
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
