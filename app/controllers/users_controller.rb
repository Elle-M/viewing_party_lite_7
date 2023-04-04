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

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      #why isnt this working? I have checked it in the User model and it is there
    flash[:success] = "Welcome, #{user.name}!"
    redirect_to root_path
    else
      flash[:alert] = "Sorry, your credentials are bad."
      redirect_to login_path
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