class Flag < ActiveRecord::Base
  include HasUser
  attr_accessible :message, :flaggable_type, :flaggable_id
end
