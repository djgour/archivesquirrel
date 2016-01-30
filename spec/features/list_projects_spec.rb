require 'spec_helper'

describe "Looking for lists of projects" do

  before do
    @user = User.create!(user_attributes)
    @user2 = User.create!(user_attributes(login: "user2",
                                          email: "user2@example.com"))
    @project = Project.create!(project_attributes(name: "Project 1", 
                                                  owner: @user))
    @project2 = Project.create!(project_attributes(name: "Project 2", 
                                                  owner: @user))
    @project3 = Project.create!(project_attributes(name: "Project 3", 
                                                  owner: @user2))
    sign_in @user
  end

  context "viewing your homepage" do
    it "shows you all the projects you're involved in" do
      visit root_url
      expect(page).to have_link @project.name
      expect(page).to have_link @project2.name
    end
  
    it "doesn't show you other projects" do
      visit root_url
      expect(page).not_to have_link @project3.name
    end
  end
end
