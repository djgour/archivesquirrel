require 'spec_helper'

describe "Editing a user's profile" do

  it "updates the user's details and then shows the updated profile" do
    user = User.create!(user_attributes)
    visit edit_user_url(user)
    fill_in "user_name", with: "Joseph Demonstration"
    click_button 'Save Changes'

    expect(current_path).to eq(user_path(user))

    expect(page).to have_text "Joseph Demonstration"
  end

  it "does not update the user's details with invalid data" do
    user = User.create!(user_attributes)
    visit edit_user_url(user)
    fill_in "user_email", with: ""

    click_button 'Save Changes'

    expect(page).to have_text('error')
  end

  it "should not let you edit the username" do
    user = User.create!(user_attributes)
    visit edit_user_url(user)
    expect(page).not_to have_field('user_login')
  end
end