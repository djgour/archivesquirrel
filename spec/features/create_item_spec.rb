require 'spec_helper'

describe "Creating a new item" do
  before do
    @project_owner = User.create!(user_attributes)
    @project_member = User.create!(user_attributes(login: "member",
                                          email: "member@example.com"))
    @project = Project.create!(project_attributes(owner: @project_owner))
    @project.participates.create!(user: @project_member)  
    sign_in @project_owner
  end
  
  it "can be done from the project homepage" do
    visit project_path(@project)
    click_link "Add Item"
    expect(current_path).to eq(new_project_item_path(@project))
  end
  
  it "saves an item with valid information" do
    visit new_project_item_path(@project)
    fill_in "item_name", with: "Example Item"
    fill_in "item_description", with: "This is a description of an 
                                      example item."
    expect {click_button "Create Item" }.to change(Item, :count).by(1)
    expect(page).to have_text('successfully added')
    expect(page).to have_text('Example Item')
    expect(page).to have_text('This is a description')
  end
  
  it "does not save an item it's invalid" do
    visit new_project_item_path(@project)
    expect{ click_button "Create Item"}.not_to change(Item, :count)
    expect(page).to have_text("Name can't be blank")
  end
  
  it "can be done by a project member" do
    sign_out @project_owner
    sign_in @project_member
    visit project_path(@project)
    click_link "Add Item"
    fill_in "item_name", with: "Member-added item"
    expect{ click_button "Create Item" }.to change(Item, :count).by(1)
  end
  
end