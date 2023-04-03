require "rails_helper"

describe User do
	describe "relationships" do
		it { should have_many :user_parties }
		it { should have_many(:parties).through(:user_parties) }
	end

	describe "validations" do
		it { should validate_presence_of :email }
		it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password_digest}
    it { should have_secure_password }
		it "should validate that it's an email" do
			john = User.new(name: "John Smith", email: "jsmith@gmail.com", password: "password", password_confirmation: "password")
      # expect(john.valid?).to be(true)
      expect(john).to_not have_attribute(:password)
      expect(john.password_digest).to_not eq("password")
  
			john = User.new(name: "John Smith", email: "fasd324223")
			expect(john.valid?).to be(false)
		end
	end

	describe "::instance methods" do
		let!(:user_1) { User.create!(name: "John", email: "john@email.com", password: "password", password_confirmation: "password" ) }
		let!(:user_2) { User.create!(name: "Mary", email: "mary@email.com", password: "password1", password_confirmation: "password1") }
		let!(:user_3) { User.create!(name: "Lisa", email: "lisa@email.com", password: "password2", password_confirmation: "password2") }

		let!(:party_1) { Party.create!(runtime: 100, duration: 120, date: "4/4/2023", time: "4:00", movie_id: 76_341) }
		let!(:party_2) { Party.create!(runtime: 100, duration: 136, date: "4/7/2023", time: "5:00", movie_id: 76_342) }
		let!(:party_3) { Party.create!(runtime: 100, duration: 127, date: "4/2/2023", time: "6:00", movie_id: 76_343) }
		let!(:party_4) { Party.create!(runtime: 100, duration: 111, date: "3/29/2023", time: "7:00", movie_id: 76_344) }

		let!(:user_party_1) { UserParty.create!(user: user_1, party: party_1, host: true) }
		let!(:user_party_2) { UserParty.create!(user: user_2, party: party_1, host: false) }
		let!(:user_party_3) { UserParty.create!(user: user_3, party: party_1, host: false) }
		let!(:user_party_4) { UserParty.create!(user: user_2, party: party_2, host: true) }
		let!(:user_party_5) { UserParty.create!(user: user_3, party: party_2, host: false) }
		let!(:user_party_6) { UserParty.create!(user: user_3, party: party_3, host: true) }
		let!(:user_party_7) { UserParty.create!(user: user_1, party: party_3, host: false) }
		let!(:user_party_8) { UserParty.create!(user: user_1, party: party_4, host: true) }

		it "::host?" do
			expect(user_1.host?(party_1)).to be(true)
			expect(user_2.host?(party_1)).to be(false)
			expect(user_1.host?(party_3)).to be(false)
		end

		it "::my_parties" do
			expect(user_1.my_parties).to eq([party_1, party_4])
		end

		it "::party_invites" do
			expect(user_1.party_invites).to eq([party_3])
		end
	end
end