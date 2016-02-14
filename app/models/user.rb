class User < ActiveRecord::Base
  has_secure_password
  validates :login, presence: true,
                    format: /\A(?=[a-z])[a-z\d_]+\Z/i,
                    uniqueness: { case_sensitive: false }

  validates :email, presence: true,
                    format: /\A\S+@\S+\z/,
                    uniqueness: { case_sensitive: false }

  has_many :projects
  has_many :received_invitations, :class_name => "Invitation", :foreign_key => "invitee_id"
  has_many :given_invitations, :class_name => "Invitation", :foreign_key => "inviter_id"
  has_many :participates, dependent: :destroy
  has_many :participations, through: :participates, source: :project
  
  def all_projects
    all_projects = self.projects + self.participations.all
    Project.where(id: all_projects.map(&:id))
  end
  
  def is_member_of_project?(project)
    self.all_projects.find_by(id: project.id)
  end
  
  def has_received_invitations?
    self.received_invitations.any?
  end
  
  def has_given_invitations?
    self.given_invitations.any?
  end
  
  def is_invited_to_project?(project)
    self.received_invitations.find_by(project_id: project.id)
  end
  
  def owns_project?(project)
    self.projects.find_by(id: project.id)
  end
  
  def participates_in_project?(project)
    self.projects.find_by(id: project.id)
  end
end
