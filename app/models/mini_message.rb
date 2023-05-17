class MiniMessage < ApplicationRecord

  belongs_to :user
  belongs_to :mini_room

end
