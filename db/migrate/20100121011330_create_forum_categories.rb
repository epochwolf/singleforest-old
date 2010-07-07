class CreateForumCategories < ActiveRecord::Migration
  def self.up
    create_table :forum_categories do |t|
      t.string :title, :null => false
      t.text :summary
      t.text :description
      t.integer :forum_id, :null => false
      t.boolean :admin_only, :null => false, :default => false
      t.boolean :news, :null => false, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :forum_categories
  end
end
