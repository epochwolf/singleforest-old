class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :title, :null => false
      t.text :description
      t.integer :user_id, :null => false
      t.boolean :series, :null => false, :default => false
      t.integer :literatures_count, :null => false, :default => 0
      t.boolean :soft_delete, :null => false, :default => false
      t.timestamps
    end
    
    add_index :collections, [:title, :user_id], :unique => true
  end
  
  def self.down
    drop_table :collections
  end
end
