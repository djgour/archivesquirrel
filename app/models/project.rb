class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  has_many :invitations
  has_many :participates, dependent: :destroy
  has_many :participants, through: :participates, source: :user
  has_many :items
  validates :name, presence: true
  validates :description, presence: true
  validates :owner, presence: true
  
  def project_admin?(user)
    project_admins.include? user
  end
  
  def all_members
    all_members = [self.owner] + self.participants.all
    User.where(id: all_members.map(&:id))
  end
  
  def project_member?(user)
    all_members.include? user
  end
  
  private
  
    def project_admins
      # Expand once non-owner participants can be made into project admins 
      admins = [self.owner]
    end
end
