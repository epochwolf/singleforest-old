class CreateCommentThreads < ActiveRecord::Migration
  def self.up
    create_table :comment_threads do |t|
      t.references :commentable, :null => false, :polymorphic => true
      t.boolean :lock, :null => false, :default => false
      t.boolean :admin_only, :null => false, :default => false
      t.timestamps
    end
    
    add_index :comment_threads, [:commentable_type, :commentable_id], :unique => true
  end

  def self.down
    drop_table :comment_threads
  end
end
