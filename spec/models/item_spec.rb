require 'spec_helper'

describe "An item" do

  it "requires a name" do
    item = Item.new(item_attributes(name: ""))

    item.valid?

    expect(item.errors[:name].any?).to eq(true)
  end

  it "requires a level" do
    item = Item.new(item_attributes(level: ""))

    item.valid?

    expect(item.errors[:level].any?).to eq(true)
  end

end
