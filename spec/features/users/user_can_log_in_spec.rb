require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(email: "bob@email.com", password_confirmation: "test")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq(login_path)

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome, #{user.email}")
  end

  it "cannot log in with invalid credentials" do
    user = User.create(email: "bob@email.com", password_confirmation: "test")

    visit login_path

    fill_in :email, with: user.email
    fill_in :password, with: "incorrect password"
  
    click_on "Log In"
  
    expect(current_path).to eq(login_path)
  
    expect(page).to have_content("Sorry, your credentials are bad.")
  end  
end