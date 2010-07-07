class CreateLiteratures < ActiveRecord::Migration
  def self.up
    create_table :literatures do |t|
      t.string :title, :null => false
      t.integer :user_id, :null => false
      t.integer :word_count
      t.text :artists_note
      t.text :note_to_commenters
      t.text :contents, :null => false
      t.text :summary
      t.integer :collection_id
      t.integer :collection_order
      t.boolean :mature, :null => false, :default => false
      t.boolean :mature_sex, :null => false, :default => false
      t.boolean :mature_violence, :null => false, :default => false
      # TODO: Add fields for work in progress and critique
      t.boolean :draft, :null => false, :default => true
      t.boolean :critique, :null => false, :default => false
      t.boolean :hide, :null => false, :default => false
      t.boolean :soft_delete, :null => false, :default => false
      t.timestamps
      
    end  
    add_index :literatures, :user_id
    add_index :literatures, :created_at
  end
  
  def self.down
    drop_table :literatures
  end
end
