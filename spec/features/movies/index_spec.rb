require "rails_helper"

describe "Movie Index Page", :vcr do   
  before(:each) do
    @user_1 = User.create(name: "Bob", email: "bob@myemail.com")
    visit user_discover_index_path(@user_1)
    fill_in :movie_title, with: "Shawshank"
    within "#search" do
      click_button "Search"
    end
  end

  xit "shows the movie title as a link" do
    expect(page).to have_link("The Shawshank Redemption")
  end

  xit "shows the movie vote average" do
    expect(page).to have_content("Vote Average: 8.701")
  end
end  