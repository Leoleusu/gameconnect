class Notifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :sender, foreign_key: { to_table: "users" }
      t.references :receiver, foreign_key: { to_table: "users" }
      t.references :post, foreign_key: { to_table: "posts" }
      t.references :comment, foreign_key: { to_table: "comments" }
      t.string :action, null: false
      t.boolean :is_check, null: false, default: false
      t.timestamps
    end
  end
end
