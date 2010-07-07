class Notification < ActiveRecord::Base
  attr_accessible :user_id, :object_type, :object_id, :action, :object_owner_id
end
