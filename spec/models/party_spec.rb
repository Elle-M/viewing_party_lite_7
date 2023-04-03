require "rails_helper"

describe Party do
	describe "relationships" do
		it { should have_many :user_parties }
		it { should have_many(:users).through(:user_parties) }
	end
	
	describe "validations" do
		# let!(:party_1) { Party.new(runtime: 134, duration: 120, date: "4/4/2023", time: "4:00", title: "The Shawshank Redemption") }
		# let!(:party_2) { Party.new(runtime: 113, duration: 120, date: "4/4/2023", time: "4:00", title: "The Shawshank Redemption") }
		
		xit "does not allow creation of party if duration is shorter than runtime" do
			party_1 = Party.new(runtime: 134, duration: 120, date: "4/4/2023", time: "4:00", title: "The Shawshank Redemption")

			expect(party_1.save).to eq(false)

			party_1 = Party.new(runtime: 134, duration: 140, date: "4/4/2023", time: "4:00", title: "The Shawshank Redemption")

			expect(party_1.save).to eq(true)
		end
	end

	describe "::instance methods" do
		let!(:user_1) { User.create!(name: "John", email: "john@email.com") }
		let!(:user_2) { User.create!(name: "Mary", email: "mary@email.com") }
		let!(:user_3) { User.create!(name: "Lisa", email: "lisa@email.com") }

		let!(:party_1) { Party.create!(runtime: 110, duration: 120, date: "4/4/2023", time: "4:00", movie_id: 76341) }
		let!(:party_2) { Party.create!(runtime: 120, duration: 136, date: "4/7/2023", time: "5:00", movie_id: 76342) }
		let!(:party_3) { Party.create!(runtime: 120, duration: 127, date: "4/2/2023", time: "6:00", movie_id: 76343) }
		let!(:party_4) { Party.create!(runtime: 110, duration: 111, date: "3/29/2023", time: "7:00", movie_id: 76344) }

		let!(:user_party_1) { UserParty.create!(user: user_1, party: party_1, host: true) }
		let!(:user_party_2) { UserParty.create!(user: user_2, party: party_1, host: false) }
		let!(:user_party_3) { UserParty.create!(user: user_3, party: party_1, host: false) }
		let!(:user_party_4) { UserParty.create!(user: user_2, party: party_2, host: true) }
		let!(:user_party_5) { UserParty.create!(user: user_3, party: party_2, host: false) }
		let!(:user_party_6) { UserParty.create!(user: user_3, party: party_3, host: true) }
		let!(:user_party_7) { UserParty.create!(user: user_1, party: party_3, host: false) }
		let!(:user_party_8) { UserParty.create!(user: user_1, party: party_4, host: true) }

		xit "::host" do
			expect(party_1.host).to eq(user_1)
			expect(party_1.host).to_not eq(user_2)
			expect(party_3.host).to eq(user_3)
		end

	end
end