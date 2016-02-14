require 'spec_helper'

describe "Viewing a project" do
  
  before do
    @user = User.create!(user_attributes)
    @user2 = User.create!(user_attributes(name:  nil,
                                          login: "user2",
                                          email: "user2@example.com"))
    @project = Project.create!(project_attributes(owner: @user))
    sign_in @user
  end
  
  it "should show the project's details" do
     visit project_url(@project)
     expect(page).to have_text(@project.name)
     expect(page).to have_text(@project.description)
     expect(page).to have_link(@user.name)
  end
  
  it "should show the participants" do
    @project.participates.create!(user: @user2)
    visit project_url(@project)
    expect(page).to have_text(@user2.login)
  end
  
end