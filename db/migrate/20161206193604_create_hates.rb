class CreateHates < ActiveRecord::Migration
  def change
    create_table :hates do |t|
      t.integer :post_id
      t.integer :from_id
      t.integer :to_id
      t.timestamps null: false
    end
    add_index :hates, :post_id
    add_index :hates, :from_id
  end
end
