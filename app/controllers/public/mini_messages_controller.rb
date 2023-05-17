class Public::MiniMessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    mini_message = MiniMessage.new(mini_message_params)
    mini_message.user_id = current_user.id
    if mini_message.save
      redirect_to mini_room_path(mini_message.mini_room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def mini_message_params
    params.require(:mini_message).permit(:mini_room_id, :body)
  end
end
