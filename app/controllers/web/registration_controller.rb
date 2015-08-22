class Web::RegistrationController < ApplicationController
	# GET /web/account/new
	def new
		@user = User.new
	end

	# POST /web/account/create
	def create
		@user = User.new registration_params
		if @user.save
      # authentication goes here
      flash[:notice] = "Successful registration!"
			redirect_to controller: '/web/articles', action: :index
		else
			render :new
		end
	end

	private
	def registration_params
    params.require(:user).permit(:username, :name, :surname, :email, :password)
	end
end
