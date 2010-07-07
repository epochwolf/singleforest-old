class LiteratureTags < ActiveRecord::Migration
  def self.up
    create_table :literatures_tags, :id => false  do |t|
      t.integer :literature_id
      t.integer :tag_id
    end
    
    add_index :literatures_tags, [:literature_id, :tag_id]
  end

  def self.down
    drop_table :literatures_tags
  end
end
