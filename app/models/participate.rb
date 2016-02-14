class Participate < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :user, uniqueness: { scope: :project }
end
