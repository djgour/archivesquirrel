require 'spec_helper'

describe "The homepage" do
  before do
    visit root_url
  end
  
  it "should have the app's name as its title" do
    expect(page).to have_title('Archivesquirrel')
  end

  it "should have log-in link" do
    expect(page).to have_link('Log In')
  end
end