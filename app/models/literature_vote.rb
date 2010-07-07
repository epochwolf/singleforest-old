class LiteratureVote < ActiveRecord::Base
  belongs_to :literature, :dependent => :delete
  belongs_to :user, :dependent => :delete
  
  #handled by an index
  #validates_uniqueness_of :literature, :scope => :user
  
  validates_presence_of :user
  validates_presence_of :literature
  validates_presence_of :vote
  validates_inclusion_of :vote, :in => [1, 0, -1]
  
  attr_accessible :literature_id, :literature, :vote
end
