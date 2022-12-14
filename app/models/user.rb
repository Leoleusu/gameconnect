class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts,dependent: :destroy
         has_many :favorites,dependent: :destroy
         has_many :comments,dependent: :destroy

         #フォローした・されたの関係
         has_many :relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
         has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

         #フォロー一覧・フォロワー一覧画面に使う
         has_many :followings, through: :relationships, source: :follow
         has_many :followers, through: :reverse_of_relationships, source: :follower

         #通知関係
         has_many :active_notifications, class_name: "Notifications", foreign_key: "visitor_id", dependent: :destroy
         has_many :passive_notifications, class_name: "Notifications", foreign_key: "visited_id", dependent: :destroy

  #ゲストユーザーを作る
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

#フォロー関係の整理
  #フォローする時の処置
  def follow(user_id)
    relationships.create(follower_id: user_id)
  end
  #フォローを外す時の処理
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
  #フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end

  #フォロー時の通知を作成する
  def create_notification_follow(current_user)
    temp = Notifications.where(["visitor_id = ? and visited_id = ? and action = ? ", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

end
