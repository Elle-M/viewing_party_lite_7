class User < ApplicationRecord
	has_many :user_parties
	has_many :parties, through: :user_parties
	validates :email, uniqueness: true,
										presence: true,
										format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :password_digest
  has_secure_password

	def host?(party)
		user_party = UserParty.find_by(party: party)
		user_party.user_id == self.id
	end

	def my_parties
		parties.joins(:user_parties).where(user_parties: {host: true}).distinct
	end

	def party_invites
		parties.joins(:user_parties).where(user_parties: {host: false}).distinct
	end
end