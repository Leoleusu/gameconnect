class BoardComments < ActiveRecord::Migration[6.1]
  def change
    create_table :board_comments do |t|
      t.references :board, foreign_key: { to_table: "boards" }
      t.references :user, foreign_key: { to_table: "users" }
      t.string :body, null: false
      t.timestamps
    end
  end
end
