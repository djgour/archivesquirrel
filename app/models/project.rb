class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  has_many :items
  validates :name, presence: true
  validates :description, presence: true
  validates :owner, presence: true
end
