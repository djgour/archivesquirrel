require 'spec_helper'

describe "Viewing an item" do

  it "should show the item's name, level and description" do
    item = Item.create!(item_attributes)

    visit item_url(item)

    expect(page).to have_text(item.name.titleize)
    expect(page).to have_text(item.level.titleize)
    expect(page).to have_text(item.description)

  end
end