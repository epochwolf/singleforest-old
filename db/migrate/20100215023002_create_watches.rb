class CreateWatches < ActiveRecord::Migration
  def self.up
    create_table :watches do |t|
      t.integer :watcher_id, :null => false
      t.integer :watchee_id, :null => false
      t.boolean :public, :null => false, :default => true
      t.boolean :collections, :null => false, :default => true
      t.boolean :literature, :null => false, :default => true
      t.boolean :scratchpads, :null => false, :default => true
      t.boolean :other, :null => false, :default => true
      t.timestamps
    end
  end
  
  def self.down
    drop_table :watches
  end
end
