class NewDay < ActiveRecord::Migration
  def change
    #users stuff
    create_table :users do |t|
      t.string :name,              null: false, default: ""
      t.string :password_digest,   null: false, default: ""
      t.string :profile_image,     default: "http://i.imgur.com/TM1CRMy.png"
      t.boolean :admin,            null: false, default: false
      t.timestamps null: false
    end

    add_index :users, :name, unique: true
    
    
    #hates stuff
    create_table :hates do |t|
      t.integer :post_id
      t.integer :from_id
      t.integer :to_id
      t.timestamps null: false
    end
    add_index :hates, :post_id
    add_index :hates, :from_id
    
    #likes stuff
    create_table :likes do |t|
      t.integer :post_id
      t.integer :from_id
      t.integer :to_id
      t.timestamps null: false
    end
    add_index :likes, :post_id
    add_index :likes, :from_id
    
    #followers stuff
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
      t.timestamps null: false
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:followed_id, :follower_id], unique: true
    
    #post stuff
    create_table :posts do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:user_id, :created_at]
    
  end
    
end