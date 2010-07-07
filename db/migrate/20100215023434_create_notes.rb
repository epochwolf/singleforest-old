class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :sender_id, :null => true
      t.integer :receiver_id, :null => true
      t.string :title, :null => true
      t.text :contents, :null => true
      t.boolean :read, :null => true, :default => false
      t.boolean :flagged, :null => true, :default => false
      t.boolean :soft_delete, :null => true, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :notes
  end
end
