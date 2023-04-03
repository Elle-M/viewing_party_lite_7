require "rails_helper"

describe "Movie Show Page", :vcr do
	before(:each) do
    @user_1 = User.create(name: "Bob", email: "bob@myemail.com")
    # visit user_discover_index_path(@user_1)
    # fill_in :movie_title, with: "Shawshank"
    # click_button "Search"

		# click_link "Movie: The Shawshank Redemption"
		visit "/users/#{@user_1.id}/movies/278"
  end

	xit { expect(current_path).to eq("/users/#{@user_1.id}/movies/278") }

	describe "movie's detail page" do
		xit "has a button to create a viewing party" do
			expect(page).to have_button("Create Viewing Party")

			click_button "Create Viewing Party"

			expect(current_path).to eq(new_user_movie_party_path(@user_1, 278))
		end

		xit "has a button to return to Discovery Page" do
			expect(page).to have_button("Return to Discover Page")
			
			click_button "Return to Discover Page"

			expect(current_path).to eq(user_discover_index_path(@user_1))
		end
  end

  xit "has a title, average vote, runtimes, genres, summary, cast, total reviews, and author" do
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to have_content("Vote Average: 8.701")
    expect(page).to have_content("Runtime: 142")
    expect(page).to have_content("Genres: Drama Crime") 
    expect(page).to have_content("Summary: Framed in the 1940s for the double murder of his wife")
    expect(page).to have_content("Cast: Tim Robbins Morgan Freeman")
    expect(page).to have_content("Total Reviews: 8")
    expect(page).to have_content("Reviews: elshaarawy")
    expect(page).to have_content("very good movie 9.5/10 محمد الشعراوى")
  end
end  

