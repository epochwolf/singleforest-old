class Watch < ActiveRecord::Base
  attr_accessible :watcher_id, :watchee_id, :public, :collections, :literature, :scratchpads, :other
end
