class CreateMiniEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :mini_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mini_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
