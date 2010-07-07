class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :comment_thread_id, :null => false
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.text :contents, :null => false
      t.integer :user_id, :null => false
      t.boolean :soft_delete, :null => false, :default => false
      t.timestamps
    end
    
    add_index :comments, :comment_thread_id
    add_index :comments, :parent_id
    add_index :comments, [:rgt, :lft]
  end
  
  def self.down
    drop_table :comments
  end
end
