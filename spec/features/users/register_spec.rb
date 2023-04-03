require "rails_helper"

describe 'register page', :vcr do
	before do
		visit register_path
	end

	describe "there is a form to create a new user" do
		it "has the form" do
			expect(page).to have_field("Name")
			expect(page).to have_field("Email")
      # save_and_open_page
      # expect(page).to have_field("Password")
      # expect(page).to have_field("Password Confirmation")
			expect(page).to have_button("Register")
		end
		
		it "can register a new user" do
			fill_in "Name", with: "John Doe"
			fill_in "Email", with: "johndoe@email.com"

      password = "password"
      password_confirmation = "password"

      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation, match: :prefer_exact
			click_button "Register"

      user = User.find_by(email: "johndoe@email.com")
			expect(current_path).to eq(user_path(user))
		end

		it "will not allow a user to create account if email is invalid" do
			fill_in "Name", with: "John Doe"
			fill_in "Email", with: "johndoe"
			click_button "Register"
			
			expect(page).to have_content("Email is invalid")
		end

    it "redirects to the `/register` page user fails to fill in name, unique email, OR matching passwords" do
      password = "password"
      password_confirmation = "password"
      
      fill_in "Name", with: "John Doe"
      fill_in "Email", with: "johndoe"
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password_confirmation, match: :prefer_exact
      click_button "Register"
      
      expect(current_path).to eq(register_path)
    end
	end
end