require 'spec_helper'

describe "Creating an aggregation" do
  before do
    @project_owner = User.create!(user_attributes)
    @project_member = User.create!(user_attributes(login: "member",
                                          email: "member@example.com"))
    @project = Project.create!(project_attributes(owner: @project_owner))
    @project.participates.create!(user: @project_member)  
    @item = Item.create!(item_attributes(project: @project,
                                user: @project_owner))
    TopLevelRelationship.create!(project: @project,
                                 item: @item,
                                 relationship: "default" )
    sign_in @project_owner    
  end
  
  it "lets you add an item to a top-level item" do
    visit root_path
    click_link @project.name
    click_link @item.name
    click_link "Add Item"
    fill_in "item_name", with: "Example Aggregation Item"
    fill_in "item_description", with: "This is an example child item."
    expect{click_button "Add Item"}.to change(Item, :count).by(1)
    expect(page).to have_text('Example Aggregation Item')
    expect(page).to have_text('example child item')
    expect(page).to have_link @item.name
  end
  
  context "when top-level items have child items" do
    before do
      @sub_item = Item.create!(user: @project_owner,
                               project: @project,
                               name: "Example Aggregation Item",
                               description: "This is an example child item.")
      ItemRelationship.create!(parent: @item, child: @sub_item)
    end
    
    it "lets you add an item to a child item" do
      visit project_item_path(@project, @sub_item)
      click_link "Add Item"
      fill_in "item_name", with: "Example Aggregation Sub-item"
      fill_in "item_description", with: "This is a sub-item of an aggregation."
      expect{click_button "Add Item"}.to change(Item, :count).by(1)
      expect(page).to have_text('Example Aggregation Sub-item')
      expect(page).to have_text('sub-item of an aggregation.')
      expect(page).to have_link("Example Aggregation Item")
    end
  end
end