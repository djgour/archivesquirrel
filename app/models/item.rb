class Item < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :project
  validates :project, presence: true
  belongs_to :user
  validates :user, presence: true
  
  def deletable_by?(user)
    self.creator?(user) || self.admin?(user)
  end
  
  def creator?(user)
    self.user == user
  end
  
  def admin?(user)
    self.project.project_admin?(user)
  end
end
