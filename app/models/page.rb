class Page < ActiveRecord::Base
  validates_presence_of :contents
  validates_presence_of :title
  validates_uniqueness_of :title_slug, :allow_nil => false
  
  named_scope :visible, :conditions => {:hide => false}
  
  attr_accessible :title, :contents, :hide
  
  def title=(str)
    self[:title] = str
    self.title_slug = self.title.parameterize unless str.nil?
  end
  
  def to_param
    self.title_slug
  end
  
end
