class CreateMiniRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :mini_rooms do |t|

      t.timestamps
    end
  end
end
