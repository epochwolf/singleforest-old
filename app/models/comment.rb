class Comment < ActiveRecord::Base
  include HasUser
  #these need to be available before acts_as_nested_set
  attr_accessible :contents, :parent_id
  attr_readonly :parent_id
  acts_as_nested_set :scope => :comment_thread
  #acts_as_tree :scope => :comment_thread_id
  
  belongs_to :comment_thread
  
  validates_presence_of :comment_thread_id
  validates_presence_of :contents
  validates_presence_of :admin_note, :if => :deleted
  
  def commentable
    self.comment_thread.commentable
  end
  
  def deleted
    !self.deleted_at.nil?
  end
  
  def deleted=(bool)
    if bool
      self.deleted_at = DateTime.now
    else
      self.deleted_at = nil
    end
  end
  
end
