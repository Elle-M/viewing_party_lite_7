class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		user = User.new(user_params)
		if user.valid?
			user.save
      flash[:success] 
			redirect_to user_path(user)
		else
			flash[:alert] = error_message(user.errors)
			redirect_to register_path
		end
	end

	def show
		@user = User.find(params[:id])
    @my_parties = @user.my_parties
		@party_invites = @user.party_invites
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end