class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :post_id
      t.integer :from_id
      t.integer :to_id
      t.timestamps null: false
    end
    add_index :likes, :post_id
    add_index :likes, :from_id
  end
end
