class Web::SessionController < ApplicationController
	# GET /web/account/login
	def new
    @user = UserForm.new
	end

	# POST /web/account/login
	def create
    @user = UserForm.new session_params
    if user = @user.save
      session[:current_user_id] = user.id
      return redirect_to controller: '/web/articles', action: :index
    end
    flash[:error] = "Password or login is incorrect" if @user.valid?
    render :new
	end

  private
  def session_params
    params.require(:user).permit(:login, :password)
  end
end
