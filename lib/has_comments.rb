module HasComments
  def self.included(mod)
    mod.has_one :comment_thread, :as => :commentable
    mod.has_many :comments, :through => :comment_thread
    mod.after_create :create_comment_thread_callback
    mod.before_update :update_comment_thread
  end
  
  def create_comment_thread_callback #avoid clobbering create_comment_thread
    self.create_comment_thread # TODO: Reduce this to a single call if possible.
    self.update_comment_thread
  end
  
  def update_comment_thread
    lock = false
    ct = self.comment_thread
    
    lock ||= self.try(:soft_delete?)
    lock ||= self.try(:hide?)
    #allow_comments? overrides default options
    lock = !self.try(:allow_comments?) if self.respond_to?(:allow_comments?)
    
    #set the stuff and let active record figure out if anything changed.
    ct.lock = lock
    ct.admin_only = self.admin_only? if self.respond_to?(:admin_only)
    ct.save #won't hit the database if nothing changed
  end
end