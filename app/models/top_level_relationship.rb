class TopLevelRelationship < ActiveRecord::Base
  belongs_to :project
  belongs_to :item
end
