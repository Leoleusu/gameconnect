class Relationship < ApplicationRecord
  #フォローした人
  belongs_to :follow, class_name: "User"

  #フォローされた人
  belongs_to :follower, class_name: "User"
end
