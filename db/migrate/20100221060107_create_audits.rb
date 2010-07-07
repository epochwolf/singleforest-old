class CreateAudits < ActiveRecord::Migration
  def self.up
    create_table :audits do |t|
      t.integer :user_id, :null => false
      t.string :object_type
      t.integer :object_id
      t.string :action
      t.text :changeset
      t.text :note, :null => false
      t.timestamps
    end
    
    add_index :audits, :user_id
  end
  
  def self.down
    drop_table :audits
  end
end
