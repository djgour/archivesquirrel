require 'spec_helper'

describe "Editing an item" do
  before do
    @project_owner = User.create!(user_attributes)
    @project_member = User.create!(user_attributes(login: "member",
                                          email: "member@example.com"))
    @project = Project.create!(project_attributes(owner: @project_owner))
    @project.participates.create!(user: @project_member)  
    @item = Item.create!(item_attributes(project: @project,
                                user: @project_owner))
    sign_in @project_owner
  end
  
  context "when a user owns the item's project" do
    it "should let them edit the item" do
      visit project_item_path(@project, @item)
      click_link "Edit"
      expect(current_path).to eq(edit_project_item_path(@project, @item))
      fill_in "item_name", with: "352 Avenue Blvd."
      click_button "Save Changes"
      expect(page).to have_text("352 Avenue Blvd.")
      expect(page).to have_text("Changes saved.")
    end
    
    it "shouldn't let them make the item invalid" do
      visit edit_project_item_path(@project, @item)
      fill_in "item_name", with: ""
      click_button "Save Changes"
      expect(page).to have_text(@item.name)
      expect(page).to have_text("errors")
    end
  end
  
  context "when a user is a member of the item's project" do
    it "should let them edit the item" do
      visit project_item_path(@project, @item)
      click_link "Edit"
      expect(current_path).to eq(edit_project_item_path(@project, @item))
      fill_in "item_name", with: "352 Avenue Blvd."
      click_button "Save Changes"
      expect(page).to have_text("352 Avenue Blvd.")
      expect(page).to have_text("Changes saved.")
    end
  end
  
end