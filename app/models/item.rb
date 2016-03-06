class Item < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :project
  validates :project, presence: true
  belongs_to :user
  validates :user, presence: true
end
