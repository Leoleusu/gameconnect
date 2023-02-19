class Board < ApplicationRecord
  belongs_to :user

  has_many :board_comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 20 }#「presence: true」で入力必須。「length: { maximum:  }」は文字数制限のバリデーション。今回は、２５５字以内という制限。
  validates :body, presence: true, length: { maximum: 1_535 }
end
