class CreateForumThreads < ActiveRecord::Migration
  def self.up
    create_table :forum_threads do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.integer :forum_category_id
      t.integer :user_id, :null => false
      t.boolean :admin_only, :null=> false, :default => false
      t.boolean :sink, :null => false, :default => false
      t.boolean :soft_delete, :null => false, :default => false
      t.datetime :bumped_at
      t.timestamps
    end
    
    add_index :forum_threads, :forum_category_id
    add_index :forum_threads, :bumped_at
  end
  
  def self.down
    drop_table :forum_threads
  end
end
