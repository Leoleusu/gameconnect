class MiniRoom < ApplicationRecord

  has_many :mini_entries, dependent: :destroy
  has_many :mini_messages, dependent: :destroy
end
