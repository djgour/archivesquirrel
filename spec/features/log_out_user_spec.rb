require 'spec_helper'

describe "Logging out" do

  it "removes the user_id from the session" do
    user = User.create!(user_attributes)

    sign_in(user)

    click_link 'Log Out'

    expect(page).to have_text("logged out")
    expect(page).not_to have_link("Log Out")
    expect(page).not_to have_link("user.name")
    expect(page).to have_link("Log In")
  end
end