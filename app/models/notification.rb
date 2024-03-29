class Notification < ApplicationRecord
  default_scope -> {order(created_at: :desc)}
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :board, optional: true

  belongs_to :sender, class_name: "User", foreign_key: "sender_id", optional: true
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id", optional: true
end
