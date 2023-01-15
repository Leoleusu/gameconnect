class Post < ApplicationRecord
  belongs_to :user
  has_many :favorites,dependent: :destroy
  has_many :comment,dependent: :destroy
  has_many :notifications,dependent: :destroy

  #通知作成メソッド
  def create_notification_favorite(current_user, post_id, post_user_id)
    #すでにいいねされているかを検索して、連続でいいねを行っても一度しか表示が行かないようにする
    temp = Notification.where(["sender_id = ? and receiver_id = ? and post_id = ? and action = ? ",current_user.id, user.id, id, "favorite"])
    #いいねされていない場合にのみ、通知を作る
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: post_id,
        receiver_id: post_user_id,
        action: "favorite"
      )
      #自分の投稿へのいいねに通知を送らないようにする
      if notification.sender_id == notification.receiver_id
        notification.is_check = true
      end
      notification.save if notification.valid?
    end
  end

  #お気に入りに入れているかを見るメソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索条件によって検索方法を切り替える
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("body LIKE?", "#{word}")
    elsif search == "forward_match"
      @post = Post.where("body LIKE?", "#{word}%")
    elsif search == "backward_match"
      @post = Post.where("body LIKE?", "%#{word}")
    elsif search == "partial_match"
      @post = Post.where("body LIKE?", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
