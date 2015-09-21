require 'spec_helper'

describe "Viewing an item" do

  before do
    @user = User.create!(user_attributes)
    @project = @user.projects.create!(project_attributes)
  end

  it "should show the item's name, level and description" do
    item = @project.items.create!(item_attributes)

    visit item_url(item)

    expect(page).to have_text(item.name.titleize)
    expect(page).to have_text(item.level.titleize)
    expect(page).to have_text(item.description)

  end
end