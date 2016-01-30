require 'spec_helper'

describe 'ProjectsController' do
  
  before do
    @user = User.create!(user_attributes)
  end
  
  context "when not logged in" do
    
    before do
      session[:user_id] = nil
    end
    
    it "cannot create"
    
  end
  
end