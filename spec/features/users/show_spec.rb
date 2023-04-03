require "rails_helper"

describe "User Show Page" do
  before(:each) do
    @user_1 = User.create(name: "Bob", email: "bob@myemail.com")
		@party = @user_1.parties.create!(runtime: 110, duration: 120, time: "12:00:00", date: "2021-08-01")
  end

  xit "can see the users name's dashboard at the top of the page" do
		visit user_path(@user_1)
		
    expect(page).to have_content("Bob's Dashboard")
    expect(page).to_not have_content("Sally's Dashboard")
  end

  xit "can see a button to discover movies" do
		visit user_path(@user_1)

    expect(page).to have_button("Discover Movies")
  end

  xit "list viewing parties" do
		visit user_path(@user_1)

    expect(page).to have_content("Viewing Parties")
  end

	describe "discover movies" do
		xit "takes user to discover page when the Discover Movies button is clicked" do
			visit user_path(@user_1)

			click_button "Discover Movies"

			expect(current_path).to eq(user_discover_index_path(@user_1))
		end
	end

	describe "dashboard: viewing parties" do
		let!(:user_2) { User.create!(name: "Mary", email: "mary@email.com") }
		let!(:user_3) { User.create!(name: "Lisa", email: "lisa@email.com") }

		let!(:party_1) { Party.create!(runtime: 100, duration: 120, date: "4/4/2023", time: "4:00", movie_id: 76341, image_path: "/hBcY0fE9pfXzvVaY4GKarweriG2.jpg", title: "Movie 1") }
		let!(:party_2) { Party.create!(runtime: 100, duration: 136, date: "4/7/2023", time: "5:00", movie_id: 76342, image_path: "/hBcY0fE9pfXzvVaY4GKarweriG2.jpg", title: "Movie 2") }
		let!(:party_3) { Party.create!(runtime: 100, duration: 127, date: "4/2/2023", time: "6:00", movie_id: 76343, image_path: "/hBcY0fE9pfXzvVaY4GKarweriG2.jpg", title: "Movie 3") }
		let!(:party_4) { Party.create!(runtime: 100, duration: 111, date: "4/4/2023", time: "7:00", movie_id: 76344, image_path: "/hBcY0fE9pfXzvVaY4GKarweriG2.jpg", title: "Movie 4") }

		let!(:user_party_1) { UserParty.create!(user: @user_1, party: party_1, host: true) }
		let!(:user_party_2) { UserParty.create!(user: user_2, party: party_1, host: false) }
		let!(:user_party_3) { UserParty.create!(user: user_3, party: party_1, host: false) }
		let!(:user_party_4) { UserParty.create!(user: user_2, party: party_2, host: true) }
		let!(:user_party_5) { UserParty.create!(user: user_3, party: party_2, host: false) }
		let!(:user_party_6) { UserParty.create!(user: user_3, party: party_3, host: true) }
		let!(:user_party_7) { UserParty.create!(user: @user_1, party: party_3, host: false) }
		let!(:user_party_8) { UserParty.create!(user: @user_1, party: party_4, host: true) }
		let!(:user_party_9) { UserParty.create!(user: user_2, party: party_4, host: true) }

		xit "displays viewing parties that the user has been invited to" do
			visit user_path(@user_1)

			expect(page).to have_content("Movie 1")
			expect(page).to have_content("Movie 3")
			expect(page).to have_content("Movie 4")
			expect(page).to have_xpath("//img[contains(@src,'https://image.tmdb.org/t/p/w300/hBcY0fE9pfXzvVaY4GKarweriG2.jpg')]")
		end
	end
end