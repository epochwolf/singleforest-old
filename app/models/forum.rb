class Forum < ActiveRecord::Base
  acts_as_list
  
  named_scope :visible, :conditions => {:admin_only => false}
  
  has_many :categories, :class_name => "ForumCategory"
  
  NEWS_FORUM = ["Singleforest", "News"]
  ADMIN_NEWS_FORUM = ["Admin", "News"]
  
  def self.news
    cat = ForumCategory.find_by_name(NEWS_FORUM[0])
    thread = ForumThread.find_by_name_and_forum_category_id(NEWS_FORUM[1], cat.id)
    thread
  end
  
  def self.admin_news
    cat = ForumCategory.find_by_name(ADMIN_NEWS_FORUM[0])
    thread = ForumThread.find_by_name_and_forum_category_id(ADMIN_NEWS_FORUM[1], cat.id)
    thread
  end
end
