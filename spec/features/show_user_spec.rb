require 'spec_helper'

describe "Viewing a user" do

  it "should show the user's details" do
    user = User.create!(user_attributes)

    sign_in user
    visit user_url(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text("(#{user.login})")
    expect(page).to have_text(user.description)
  end

  it "should show a user's login as the main name if they haven't entered a name" do
    user = User.create!(user_attributes(name: ""))
    sign_in user
    visit user_url(user)

    expect(page).to have_text(user.login)
    expect(page).not_to have_text("(#{user.login})")
  end

end