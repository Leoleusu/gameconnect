class Relationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follow, foreign_key: { to_table: "users" }
      t.references :follower, foreign_key: { to_table: "users" }
      t.timestamps
    end
  end
end
