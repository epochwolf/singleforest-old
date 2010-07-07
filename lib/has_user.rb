module HasUser
  def self.included(mod)
    mod.validates_presence_of :user_id
    mod.belongs_to :user
    mod.belongs_to :_user, :foreign_key => "user_id", :class_name=>"User", :select => "id, name, banned, closed"
  end
end