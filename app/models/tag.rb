class Tag < ActiveRecord::Base
  default_scope :order => :name
  has_and_belongs_to_many :literatures
  
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_format_of :name, :with => /^[a-z][a-z ]+[a-z]$/, :message => "must be lowercase"
  
  attr_accessible :name, :description
  
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
end
