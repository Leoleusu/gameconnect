class Boards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.references :user, foreign_key: { to_table: "users" }
      t.string :title, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
