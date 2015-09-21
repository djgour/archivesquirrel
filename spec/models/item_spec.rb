require 'spec_helper'

describe "An item" do

  before do
    @user = User.create!(user_attributes)
    @project = @user.projects.new(project_attributes)
  end

  it "belongs to a project" do
    item = @project.items.new(item_attributes)

    expect(item.project).to eq(@project)
  end

  it "requires a project" do
    item = Item.new(item_attributes)

    item.valid?

    expect(item.errors[:project].any?).to eq(true)
  end

  it "requires a name" do
    item = @project.items.new(item_attributes(name: ""))

    item.valid?

    expect(item.errors[:name].any?).to eq(true)
  end

  it "requires a level" do
    item = @project.items.new(item_attributes(level: ""))

    item.valid?

    expect(item.errors[:level].any?).to eq(true)
  end

end
