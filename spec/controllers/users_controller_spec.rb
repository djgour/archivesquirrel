require 'spec_helper'

describe UsersController do

  before do
    @user = User.create!(user_attributes)
  end

  context "when not logged in" do
    
    before do
      session[:user_id] = nil
    end

    it "cannot access index" do
      get :index

      expect(response).to redirect_to(login_url)
    end

    it "cannot access show" do
      get :show, id: @user

      expect(response).to redirect_to(login_url)
    end

    it "cannot access edit" do
      get :edit, id: @user

      expect(response).to redirect_to(login_url)
    end

    it "cannot access update" do
      patch :update, id: @user

      expect(response).to redirect_to(login_url)
    end

    it "cannot access destroy"

  end

  context "when logged in as a different user" do
    before do
      @wrong_user = User.create!(user_attributes(login:"example2", email: "example2@example.com"))
      session[:user_id] = @wrong_user
    end

    it "cannot edit another user" do
      get :edit, id: @user

      expect(response).to redirect_to(root_url)
    end

    it "cannot update another user" do
      patch :update, id: @user

      expect(response).to redirect_to(root_url)
    end

    it "cannot destroy another user"

  end
end