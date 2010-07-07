class ForumCategory < ActiveRecord::Base
  include ActionView::Helpers::TextHelper #needed for truncate
  belongs_to :forum
  has_many :threads, :foreign_key => "forum_catergory_id", :class_name => "ForumThread"
  has_many :top_threads, :foreign_key => "forum_catergory_id", :class_name => "ForumThread", :order => :updated_at, :limit => 3
  named_scope :visible, :conditions => {:admin_only => false}
  
  validates_presence_of :title
  validates_presence_of :summary
  validates_presence_of :forum_id
  
  before_save :match_forum_permission
  
  def to_param
    "#{self.id}-#{truncate self.title.parameterize, :omission => '-'}"
  end
  
  def match_forum_permission
    if self.forum_id_changed?
      self.admin_only = self.forum.admin_only?
    end
    true
  end
end
