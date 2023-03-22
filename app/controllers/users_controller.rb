class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		user = User.new(user_params)
		if user.valid?
			user.save
			redirect_to user_path(user)
		else
			flash[:alert] = error_message(user.errors)
			redirect_to register_path
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
	def user_params
		params.require(:user).permit(:name, :email)
	end
end