require "rails_helper"

describe "Discover Index Page" do
  before(:each) do
    @user_1 = User.create(name: "Bob", email: "bob@myemail.com")
		@party = @user_1.parties.create!(runtime: 100, duration: 120, time: "12:00:00", date: "2021-08-01")
  end

  xit "has a button to discover movies" do
    visit user_discover_index_path(@user_1)

    expect(page).to have_button("Discover Top Rated Movies")
  end

  xit "has a search field for movies" do
    visit user_discover_index_path(@user_1)

    expect(page).to have_field(:movie_title)
    expect(page).to have_button("Search")
  end

  xit "takes us to the movie index page when the discover top rated movies button is pressed", :vcr do
    visit user_discover_index_path(@user_1)

    click_button "Discover Top Rated Movies"

    expect(current_path).to eq(user_movies_path(@user_1))
  end

  xit "takes us to the movie index page when the search button is pressed", :vcr do
    visit user_discover_index_path(@user_1)

    within "#search" do
      fill_in :movie_title, with: "Bear"
      click_button "Search"
    end
    expect(current_path).to eq(user_movies_path(@user_1))
  end
end

