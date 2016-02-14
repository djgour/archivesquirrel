require 'spec_helper'

describe "a user" do

  it "requires a login name" do
    user = User.new(login: "")
    user.valid?
    expect(user.errors[:login].any?).to eq(true)
  end

  it "requires an email" do
    user = User.new(email: "")
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end

  it "can have properly formatted email addressses" do
    emails = %w[user@example.com first.last@example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end

  it "rejects improperly formatted email addresses" do
    emails = %w[user@  @example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique (case-insensitive) email address" do
    user1 = User.create!(user_attributes)

    user2 = User.new(email: user1.email.upcase)
    user2.valid?
    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "requires a unique (case-insensitve) login" do
    user1 = User.create!(user_attributes)

    user2 = User.new(login: user1.login.upcase)
    user2.valid?
    expect(user2.errors[:login].first).to eq("has already been taken")
  end

  it "doesn't permit usernames with invalid characters" do
    logins = %w[joe@example joe-example 5joe _joe]
    logins.each do |login|
      user = User.new(user_attributes(login: login))
      user.valid?
      expect(user.errors[:login].any?).to eq(true)
    end
  end

  it "is valid with the example attributes" do
    user = User.new(user_attributes)
    expect(user.valid?).to eq(true)
  end

  it "requires a password" do
    user = User.new(password: "")
    user.valid?
    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation if a password is present" do
    user = User.new(password: "secret", password_confirmation: "")
    user.valid?
    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires the password to match the password_confirmation" do
    user = User.new(password: "secret", password_confirmation: "nomatch")
    user.valid?
    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end

  it "is valid if the password matches the confirmation" do
    user = User.create!(user_attributes(password: "secret", password_confirmation: "secret"))
    expect(user.valid?).to eq(true)
  end

  it "does not require a password when updating" do
    user = User.create!(user_attributes)

    user.password = ""
    expect(user.valid?).to eq(true)
  end

  it "automatically encrypts the password into the password digest" do
    user = User.new(password: "password")
    expect(user.password_digest.present?).to eq(true)
  end
  
  it "can participate in projects created by other users" do
    user1 = User.new(user_attributes)
    user2 = User.new(user_attributes(login: "user2", 
                                     email: "user2@example.com"))
    project = Project.new(project_attributes(owner: user2))
    project.participates.new(user: user1)
    expect(project.participants).to include(user1)
  end
end
