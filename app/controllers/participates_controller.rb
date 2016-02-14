class ParticipatesController < ApplicationController
  
  def create
    invite = current_user.received_invitations.find(params[:invite_id])
    participation = Participate.new(project: invite.project,
                                   user: invite.invitee)
    if participation.save
      redirect_to root_path, notice: "You are now a participant in #{invite.project.name}."
      invite.has_been_accepted
    else
      redirect_to root_path, notice: "Hmmm. Something went wrong."
    end
  end
  
end
