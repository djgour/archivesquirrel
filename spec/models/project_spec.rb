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
  
  it "must have a valid owner" do
    project = Project.new(user_id: nil)
    project.valid?
    expect(project.errors[:owner].any?).to eq(true)
  end
  
  it "can have participants besides the owner" do
    user1 = User.new(user_attributes)
    user2 = User.new(user_attributes(login: "user2",
                                     email: "user2@example.com"))
    project = Project.new(project_attributes(owner: user1))
    user2.participates.new(project: project)
    expect(user2.participations).to include(project)
  end

end
