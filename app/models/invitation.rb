class Invitation < ActiveRecord::Base

  belongs_to :invitee, :class_name => "User"
  belongs_to :inviter, :class_name => "User"
  belongs_to :project
  
  validate :no_existing_invitation
  validate :not_existing_member
  
  def main_error
    #string for error for error notice
  end
  
  def has_been_accepted
    self.destroy
  end
  
  private
  
  def not_existing_member
    membership = self.invitee.is_member_of_project?(self.project)
    errors.add(:existing_member, "This user is already a member of the project.") if membership
  end
  
  def no_existing_invitation
    invitation = self.invitee.is_invited_to_project?(self.project)
    errors.add(:existing_invite, "This user has already been invited to the project.") if invitation
  end
  
end
