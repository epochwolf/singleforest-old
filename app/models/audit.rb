class Audit < ActiveRecord::Base
  include HasUser
  
  belongs_to :object, :as => :audited
  
  attr_accessible :user_id, :object_type, :object_id, :changeset, :note
end
