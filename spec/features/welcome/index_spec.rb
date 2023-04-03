require 'rails_helper'

describe "Welcome Index Page" do
  let!(:user_1) { User.create(name: "Bob", email: "bob2@myemail.com" ) }

  xit "can see a welcome message" do
    visit root_path

    expect(page).to have_content("Welcome to Viewing Party")
  end

  xit "can see a button to create a new user" do
    visit root_path

    expect(page).to have_button("Create New User")
  end

  xit "list existing users" do
    user_1 = User.create(name: "Bob", email: "bob@myemail.com")
    user_2 = User.create(name: "Sally", email: "sally@myemail.com")  
    visit root_path   

    expect(page).to have_content(user_1.name)      
    expect(page).to have_content(user_2.name)  
  end  

  xit "has a link to return to the welcome page" do
    visit root_path

    expect(page).to have_link("Viewing Party")
  end
end