class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title, :null => false
      t.string :title_slug, :null => false
      t.text :contents, :null => false, :default => ''
      t.boolean :lock, :null => false, :default => false
      t.boolean :hide, :null => false, :default => false
      t.timestamps
    end
    
    add_index :pages, :title_slug
  end
  
  def self.down
    drop_table :pages
  end
end
