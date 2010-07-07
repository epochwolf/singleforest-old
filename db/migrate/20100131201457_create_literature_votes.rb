class CreateLiteratureVotes < ActiveRecord::Migration
  def self.up
    create_table :literature_votes do |t|
      t.integer :user_id, :null => false
      t.integer :literature_id, :null => false
      t.integer :vote, :default => 0

      t.timestamps
    end
    
    add_index :literature_votes, [:user_id, :literature_id], :unique => true
  end

  def self.down
    drop_table :literature_votes
  end
end
