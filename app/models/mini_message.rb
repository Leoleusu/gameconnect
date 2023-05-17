class MiniMessage < ApplicationRecord

  belongs_to :user
  belongs_to :mini_room

  validates :body, precense: true, length: { maximum:140 }
end
