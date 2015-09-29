require 'spec_helper'

describe 'Signing in' do

  before do
    @user = User.create!(user_attributes)
  end

  it "allows a user to click on a link to log in" do
    visit root_url
    click_link 'Log In'

    expect(current_path).to eq(login_path)

    fill_in "login_or_email", with: @user.login
    fill_in "password", with: @user.password

    click_button "Log In"

    expect(page).to have_text("logged in")
  end

  it "allows a user log in with their email address" do
    sign_in @user

    expect(page).to have_text("logged in")
    expect(page).to have_link(@user.name)
    expect(page).to have_link("Log Out")
  end

  it "prevents a user from signing in with invalid credentials" do
    visit login_url

    fill_in "login_or_email", with: @user.login
    fill_in "password", with: "incorrectpassword"

    click_button "Log In"

    expect(page).to have_text("Invalid")
    expect(current_path).to eq(login_path)
  end

  it "takes a user to the link they wanted before they logged in" do
    user2 = User.create!(user_attributes(login: "user2", email: "user2@example.com",
                                         description: "This is the second example user."))

    visit user_url(user2)
    expect(page).to have_text("Log In")
    fill_in "login_or_email", with: @user.login
    fill_in "password", with: @user.password
    click_button "Log In"
    expect(page).to have_link(user2.email)
    expect(page).to have_text(user2.description)

  end
end