require 'spec_helper'

describe "a Project" do

  it "belongs to an owner who is a user" do
    user = User.create!(user_attributes)

    project = user.projects.new(project_attributes)

    expect(project.owner).to eq(user)
  end

  it "must have a name" do
    project = Project.new(name: "")
    project.valid?
    expect(project.errors[:name].any?).to eq(true)
  end

  it "must have a description" do
    project = Project.new(description: "")
    project.valid?
    expect(project.errors[:description].any?).to eq(true)
  end

end
