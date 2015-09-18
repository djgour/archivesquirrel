require 'spec_helper'

describe "Creating a new user" do

it "saves a valid user and shows their profile page" do

  visit register_path

  fill_in "user_login", with: "example"
  fill_in "user_email", with: "example@example.com"
  fill_in "user_password", with: "password"
  fill_in "user_password_confirmation", with: "password"
  fill_in "user_name", with: "Example User"
  fill_in "user_description", with: "An example user who uses this to contribute to an example project."

  expect { click_button "Create Account" }.to change(User, :count).by(1)

  expect(page).to have_text("successfully created")
  expect(page).to have_text("Example User")
end

it "doesn't save the user if it's invalid" do
  visit register_path

  expect { click_button 'Create Account' }.not_to change(User, :count)
end


end