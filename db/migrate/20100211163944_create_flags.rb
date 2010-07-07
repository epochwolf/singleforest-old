class CreateFlags < ActiveRecord::Migration
  def self.up
    create_table :flags do |t|
      t.integer :user_id, :null => false
      t.text :message
      t.string :flaggable_type, :null => false
      t.integer :flaggable_id, :null => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :flags
  end
end
