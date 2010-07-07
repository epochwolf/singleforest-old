class ForumThread < ActiveRecord::Base
  include HasUser, HasComments
  default_scope :order => :bumped_at
  named_scope :visible, :conditions => {:deleted_at => nil, :admin_only => false}
  
  belongs_to :category, :foreign_key => "forum_category_id", :class_name => "ForumCategory"
  
  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :forum_category_id
  
  attr_readonly :user_id
  attr_accessible :title, :content
  
  before_save :match_category
  
  
  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
  
#callbacks
  def before_create
    self[:bumped_at] = DateTime.now
  end
  
  def match_category
    if self.forum_category_id_changed?
      self.admin_only = self.category.admin_only?
    end
    true
  end
end
