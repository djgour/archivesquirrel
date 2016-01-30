require 'spec_helper'

describe "Creating a new project" do
  before do
    @user = User.create!(user_attributes)
    sign_in @user
  end

  it "can be done from a link on the home page for a logged in user" do
    visit root_url
    expect(page).to have_text('Create Project')
    click_link('Create Project')
    expect(current_path).to eq(new_project_path)
    expect(page).to have_text('Create a New Project')
  end
  
  it "save a valid project and displays the project page" do
    visit new_project_path
    fill_in "project_name", with: "Example Project"
    fill_in "project_description", with: "This is an example of a project for 
                                          test purposes."
    expect { click_button "Create Project" }.to change(Project, :count).by(1)
    expect(page).to have_text("successfully created")
    expect(page).to have_text("Example Project")
    expect(page).to have_text("This is an example")
    expect(page).to have_link(@user.name)
  end
  
  it "is not linked to if you're not logged in" do
    sign_out @user
    visit root_url
    expect(page).not_to have_text('Create Project')
  end
  
  it "isn't a page accessible to users who aren't logged in" do
    sign_out @user
    visit new_project_path
    expect(current_path).to eq(login_path)
  end
end