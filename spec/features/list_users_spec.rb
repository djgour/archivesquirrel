require 'spec_helper'

describe "Viewing a list of all users" do

  it "shows all the users" do
    user1 = User.create!(user_attributes)
    user2 = User.create!(user_attributes(name: "Example User 2", login: "example2", email: "email2@example.com"))
    user3 = User.create!(user_attributes(name: "Example User 3", login: "example3", email: "email3@example.com"))

    sign_in user1
    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end

  it "shows the user's login if they haven't provided a name" do
    user1 = User.create(user_attributes)
    user2 = User.create(user_attributes(name:"", login: "example2", email: "email2@example.com"))

    sign_in user1
    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.login)
  end
end