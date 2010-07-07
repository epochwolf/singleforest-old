class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id, :null => false
      t.string :object_type
      t.integer :object_id
      t.string :action
      t.integer :object_owner_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :notifications
  end
end
