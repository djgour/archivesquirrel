class InvitationsController < ApplicationController
  
  before_action :require_login
  
  def create
    project = get_authorized_project(params[:project]); return if performed?
    invitee = get_valid_user(params[:invitee_name]); return if performed?
    @invitation = Invitation.new(inviter: current_user, 
                                 invitee: invitee,
                                 project: project)
    if @invitation.save
      redirect_to project, notice: "Invitation sent to #{params[:invitee_name]}!"
    else
      redirect_to :back, notice: "Invitation invalid: #{@invitation.errors.first[1]}"
    end      
  end
  
  def decline
    invite = current_user.received_invitations.find(params[:invite_id])
    invite.destroy
    redirect_to :back, notice: "The invitation has been deleted."
  end
  
  def cancel
    invite = current_user.given_invitations.find(params[:invite_id])
    invite.destroy
    redirect_to :back, notice: "The invitation has been cancelled."
  end
  
  private
  
  def get_authorized_project(project_id)
    project = Project.find_by(id: project_id)
    return project if current_user.is_member_of_project?(project)
    redirect_to root_path and return false  
  end
  
  def get_valid_user(login_or_email)
    if user = find_user_by_login_or_email(login_or_email)
      return user
    else
      # Change behaviour once external invitations are implemented.
      redirect_to :back, notice: "#{login_or_email} is an invalid user."
    end
  end
  
end




