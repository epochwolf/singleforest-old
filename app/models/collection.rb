class Collection < ActiveRecord::Base
  include ActionView::Helpers::TextHelper #needed for truncate  
  include HasUser
  attr_accessible :title, :description, :series
  
  named_scope :visible, :order => :title
  
  has_many :literatures, :order => :collection_order
  
  #add scratchpads
  
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :user_id
  
  def to_param
    "#{self.id}-#{truncate self.title.parameterize, :omission => '-'}"
  end
end
