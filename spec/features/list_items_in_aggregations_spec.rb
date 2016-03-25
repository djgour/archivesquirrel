require 'spec_helper'

describe "Listing items" do
  
  before do
    @project_owner = User.create!(user_attributes)
    @project_member = User.create!(user_attributes(login: "member",
                                          email: "member@example.com"))
    @project = Project.create!(project_attributes(owner: @project_owner))
    @project.participates.create!(user: @project_member) 
    
    
    @top_level_item1 = Item.create!(name: "tli1",
                                    description: "tli1 description.",
                                    user: @project_owner,
                                    project: @project)
                                    
    @top_level_item2 = Item.create!(name: "tli2",
                                    description: "tli2 description.",
                                    user: @project_owner,
                                    project: @project)
                                    
    @second_level_item = Item.create!(name: "2ndli",
                                    description: "2ndli description.",
                                    user: @project_owner,
                                    project: @project)
    
    @third_level_item = Item.create!(name: "3rdli",
                                    description: "3rdli description.",
                                    user: @project_owner,
                                    project: @project)
                                    
    TopLevelRelationship.create!(project: @project,
                                 item: @top_level_item1,
                                 relationship: "default")
    TopLevelRelationship.create!(project: @project,
                                 item: @top_level_item2,
                                 relationship: "default")
                                 
    ItemRelationship.create!(parent: @top_level_item1, child: @second_level_item)
    ItemRelationship.create!(parent: @second_level_item, child: @third_level_item)
    sign_in @project_owner  
  end
  
  context "when viewing the home page" do
    before do
      visit project_path(@project)
    end
    
    it "shows you top-level items" do
      expect(page).to have_link(@top_level_item1.name)
      expect(page).to have_link(@top_level_item2.name)
    end
    
    it "does not show lower level items on the main page" do
      expect(page).not_to have_link(@second_level_item.name)
      expect(page).not_to have_link(@third_level_item.name)
    end
    
  end

  context "when looking at a top-level item" do
    
    it "shows you items that belong to this item" do
      visit project_item_path(@project, @top_level_item1)
      expect(page).to have_link(@second_level_item.name)
    end
  end
  
  context "when looking at a second-level item" do
    
    before do
      visit project_item_path(@project, @second_level_item)
    end
    
    it "shows you items belonging to it" do
      expect(page).to have_link(@third_level_item.name)
    end
    
    it "shows you items it belongs to" do
      expect(page).to have_link(@top_level_item1.name)
    end
  end
end




