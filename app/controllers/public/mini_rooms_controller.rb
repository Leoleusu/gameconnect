class Public::MiniRoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    mini_room = MiniRoom.create
    current_mini_entry = MiniEntry.create(user_id: current_user.id, mini_room_id: mini_room.id)
    another_mini_entry = MiniEntry.create(user_id: params[:mini_entry][:user_id], mini_room_id: mini_room.id)
    redirect_to mini_room_path(mini_room)
  end

  def index
    #ログインユーザーのダイレクトメッセージ一覧のIDを取得
    current_mini_entries = current_user.mini_entries
    my_mini_room_id = []
    current_mini_entries.each do |entry|
      my_mini_room_id << mini_entry.mini_room.id
    end
    #自分のroom_idでuser_idが自分じゃないのを取得
    @another_mini_entries = MiniEntry.where(mini_room_id: my_mini_room_id).where.not(user_id: current_user.id)
  end

  def show
    @mini_room = MiniRoom.find(params[:id])
    @mini_messages = @mini_room.mini_messages.all
    @mini_message = MiniMessage.new
    @mini_entries = @mini_room.mini_entries
    @another_mini_entry = @mini_entries.where.not(user_id: current_user.id).first
  end
end
