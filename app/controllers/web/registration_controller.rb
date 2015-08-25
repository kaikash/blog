class Web::RegistrationController < ApplicationController
  before_filter :authed_closed

	# GET /web/registration/new
	def new
		@user = User.new
	end

	# POST /web/registration
	def create
		@user = User.new registration_params
		@user.role = 1
		if @user.save
      flash[:notice] = "Successful registration."
			redirect_to controller: 'web/session', action: :new
		else
			render :new
		end
	end

	private
	def registration_params
    params.require(:user).permit(:username, :name, :surname, :email, :password)
	end
end
