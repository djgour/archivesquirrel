class Item < ActiveRecord::Base
  validates :name, presence: true
  validates :level, presence: true
  belongs_to :project
  validates :project, presence: true
end
