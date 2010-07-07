class CommentThread < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :include => :_user, :order => :lft #allows eager loading of the nested_set
  
  validates_presence_of :commentable
end
