class Posts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: { to_table: "users" }
      t.references :game, foreign_key: { to_table: "games" }
      t.string :body, null: false
      t.boolean :is_recruitment, null: false, default: true
      t.timestamps
    end
  end
end
