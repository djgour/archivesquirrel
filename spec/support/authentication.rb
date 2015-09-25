def sign_in(user)
  visit login_url
  fill_in "login_or_email", with: user.email
  fill_in "password", with: user.password
  click_button "Log In"
end