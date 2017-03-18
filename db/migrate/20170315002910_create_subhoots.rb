class CreateSubhoots < ActiveRecord::Migration
  def change
    create_table :subhoots do |t|
      t.text :content
      t.references :post, index: true, foreign_key: true
      t.references :user
      t.timestamps null: false
    end
    add_index :subhoots, [:post_id, :created_at]
  end
end
