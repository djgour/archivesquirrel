require 'spec_helper'

describe "Viewing an item" do
  before do
    @project_owner = User.create!(user_attributes)
    @project_member = User.create!(user_attributes(login: "member",
                                          email: "member@example.com"))
    @other = User.create!(user_attributes(login: "other",
                                          email: "other@example.com"))
    @project = Project.create!(project_attributes(owner: @project_owner))
    @project.participates.create!(user: @project_member) 
    @item = Item.create!(item_attributes(project: @project,
                                         user: @project_member)) 
    TopLevelRelationship.create!(project: @project,
                                 item: @item,
                                 relationship: "default" )
  end
  
  context "when you own the item's project" do
    before do
      sign_in @project_owner
    end
    
    it "should show top-level items on the project page" do
      visit project_path(@project)
      expect(page).to have_link(@item.name)
    end
    
    it "should show the item" do
      visit project_item_path(@project, @item)
      expect(page).to have_text(@item.name)
      expect(page).to have_text(@item.description)
    end
  end
  
  context "when you are a member of the project" do
    before do
      sign_in @project_member
    end
    
    it "should let you see the item" do
      visit project_path(@project)
      click_link @item.name
      expect(page).to have_text(@item.name)
      expect(page).to have_text(@item.description)
    end
  end
  
  context "when you are not a member of the items's project" do
    before do
      sign_in @other
    end
    
    it "should not show items on the project page" do
      visit project_path(@project)
      expect(page).not_to have_link(@item.name)
    end
    
    it "should not show the item" do
      visit project_item_path(@project, @item)
      expect(page).not_to have_text(@item.name)
      expect(page).not_to have_text(@item.description)
      expect(page).to have_text("not authorized")
    end
  end
end