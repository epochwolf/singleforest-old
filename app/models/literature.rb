class Literature < ActiveRecord::Base
  include ActionView::Helpers::TextHelper #needed for truncate
  include HasUser, HasComments
  
  acts_as_list :scope => :collection, :column => :collection_order
  default_scope :order => 'created_at DESC', :conditions => {:soft_delete => false}
  
  named_scope :visible, :conditions => {:hide => false}
  named_scope :finished, :conditions => {:draft => false, :hide => false}
  named_scope :workshop, :conditions => {:critique => false, :hide => false}
  named_scope :drafts, :conditions => {:draft => true}
  named_scope :hidden, :conditions => {:hide => true}
  
  
  has_and_belongs_to_many :tags
  belongs_to :collection, :counter_cache => true
  has_many :users_viewed, :through => :literature_vote, :source => :votes
  has_many :literature_votes
  
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :contents, :message => "can't be blank"
  validates_length_of :summary, :allow_nil => true, :within => 0..200, :message => "must be 200 characters or less"
  validate :max_of_five_tags, :collection_has_same_owner
  
  before_save :update_wordcount!, :mark_mature
  
  attr_accessible(:title, :tag_ids, :artists_note, :summary, :contents, :summary, 
                  :mature, :mature_sex, :mature_violence, :collection_id, :collection_order, 
                  :draft, :critique, :hide)

  attr_accessor :tags_cache
  
  def to_param
    "#{self.id}-#{truncate self.title.parameterize, :omission => '-'}"
  end
  
  def allow_comments?
    !self[:soft_deleted]
  end
  
  #validators
  def max_of_five_tags
    errors.add("tags", "More than 5 tags selected") if self.tag_ids.size > 5
  end
  
  def collection_has_same_owner
    if(self.collection_id)
      (self.user_id == self.collection.user_id)
    else
      true
    end
  end
  
  #callback: before_save
  def update_wordcount!
    text = self.contents
    Sanitize.clean(text)
    self.word_count = text.scan(/\w+(-\w+)?/).length
  end
  
  def mark_mature
    if self.mature_sex || self.mature_violence
      self.mature = true
    end
    true
  end
end
