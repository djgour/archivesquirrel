class Item < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :project
  validates :project, presence: true
  belongs_to :user
  validates :user, presence: true
  
  has_many :item_relationships, dependent: :destroy
  
  has_many :parent_relationships, foreign_key: :child_id, class_name: "ItemRelationship"
  has_many :parents, through: :parent_relationships, source: :parent
  
  has_many :child_relationships, foreign_key: :parent_id, class_name: "ItemRelationship"
  has_many :children, through: :child_relationships, source: :child
  
  has_many :top_level_relationships, dependent: :destroy
  has_many :parent_projects, through: :top_level_relationships, source: :project
  
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
