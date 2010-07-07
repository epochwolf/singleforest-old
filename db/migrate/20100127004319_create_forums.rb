class CreateForums < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.string :title, :null => false
      t.boolean :admin_only, :null => false, :default => false
      t.integer :position

      t.timestamps
    end
  
    Forum.create({:title => "Singleforest"}) 
    Forum.create({:title => "Literature"})
    Forum.create({:title => "Off Topic"}) 
    Forum.create({:title => "Admin Only", :admin_only => true})
  end

  def self.down
    drop_table :forums
  end
end
