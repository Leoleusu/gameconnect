class BoardComment < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :body, presence: true, length: { maximum: 1_500 }
end
