require 'spec_helper'

describe "Viewing a project" do
  
  before do
    @user = User.create!(user_attributes)
    sign_in @user
    @project = Project.create!(project_attributes(owner: @user))
  end
  
  it "should show the project's details" do
     visit project_url(@project)
     expect(page).to have_text(@project.name)
     expect(page).to have_text(@project.description)
     expect(page).to have_link(@user.name)
  end
  
end