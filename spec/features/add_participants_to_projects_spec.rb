require 'spec_helper'

describe "Adding participants to a project" do
  before do
    @user1 = User.create!(user_attributes)
    @user2 = User.create!(user_attributes(login: "user2",
                                          email: "user2@example.com"))
    @user3 = User.create!(user_attributes(login: "user3",
                                          email: "user3@example.com"))                                       
    @project = Project.create!(project_attributes(owner: @user1))
    sign_in @user1
  end
  
  it "can be done from the project page" do
      visit project_path(@project)
      expect(page).to have_text("Add Participants")
  end
  
  it "can be done by entering the login of the invitee" do
    visit project_path(@project)
    fill_in "invitee_name", with: @user2.login
    expect{ click_button "Invite" }.to change(Invitation, :count).by(1)
  end
  
  it "can be done by entering the email of the invitee" do
    visit project_path(@project)
    fill_in "invitee_name", with: @user2.email
    expect{ click_button "Invite" }.to change(Invitation, :count).by(1)
  end
  
  it "will not work with an invalid invitee login" do
    visit project_path(@project)
    fill_in "invitee_name", with: "bad_login"
    expect{ click_button "Invite" }.not_to change(Invitation, :count)
  end
  
  it "will display an error with an invalid invitee login" do
    visit project_path(@project)
    fill_in "invitee_name", with: "bad_login"
    click_button "Invite"
    expect(page).to have_text("invalid")
  end
  
  
  it "will not create a new invite if invitee is already invited" do
    @project.invitations.create!(inviter: @user1, invitee: @user3)
    visit project_path(@project)
    fill_in "invitee_name", with: @user3.login
    expect{ click_button "Invite" }.not_to change(Invitation, :count)
  end
  
  it "will allow you to cancel a given invitation" do
    visit project_path(@project)
    fill_in "invitee_name", with: @user2.login
    click_button "Invite"
    visit root_path
    expect{ click_button "Cancel Invitation" }.to change(Invitation, :count).by(-1)
  end
  
  it "will not create a new invite if invitee is already a participant" do
    @project.participates.create!(user: @user3)
    visit project_path(@project)
    fill_in "invitee_name", with: @user3.login
    expect{ click_button "Invite" }.not_to change(Invitation, :count)
  end
  
  
  it "will prompt you to email an invitation to join the app is email is not of
   an existing user"
   
  context "after the invitee views their homepage" do
    before do
      visit project_path(@project)
      fill_in "invitee_name", with: @user2.login
      click_button "Invite"
      sign_out @user1
      sign_in @user2
      visit root_path
    end
    
    it "should inform the invitee of the invitation" do
      expect(page).to have_text(@project.name)
      expect(page).to have_text(@user1.name)
    end
    
    it "should allow the invitee to become a participant if they accept" do
      expect{ click_button "Accept" }.to change(Participate, :count).by(1)
      expect(@project.participants).to include(@user2)
    end
    
    it "should delete the invitation if the invitee accepts" do
      expect{ click_button "Accept" }.to change(Invitation, :count).by(-1)
    end
    
    it "should allow the invitee to decline the invitation" do
      expect{click_button "Decline" }.not_to change(Participate, :count)
      expect(@project.participants).not_to include(@user2)
    end
    
    it "should delete the invitation if the invitee declines" do
      expect{ click_button "Decline" }.to change(Invitation, :count).by(-1)
    end
  end
  
  context "from the perspective of a non-member" do
    it "should not be an option" do
      sign_out @user1
      sign_in @user2
      visit project_path(@project)
      expect(page).not_to have_text("Add Participants")
      expect(page).not_to have_button("Invite")      
    end
  end
end