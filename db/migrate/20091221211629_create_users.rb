class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :openid_url, :null => false
      t.integer :rank, :null => false, :default => 0
      t.boolean :confirmed, :null => false, :default => false
      t.boolean :closed, :null => false, :default => false
      t.boolean :banned, :null => false, :default => false
      t.string :website
      t.text :biography
      t.string :api_key
      t.date :last_visited_at #Using date instead of datetime on purpose, privacy!
      t.timestamps
    end
    
    add_index :users, :name
  end
  
  def self.down
    drop_table :users
  end
end
