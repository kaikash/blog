class Web::SessionController < Web::ApplicationController
  before_filter :authed_closed, except: :destroy

  # GET /web/session/new
  def new
    @user = UserForm.new
  end

  # POST /web/session
  def create
    # @user = UserForm.new session_params
    # if user = @user.save
    #   session[:current_user_id] = user.id
    #   flash[:notice] = "Welcome back, #{user.name}!"
    #   return redirect_to controller: 'web/articles', action: :index
    # end
    # flash[:error] = "Password or login is incorrect" if @user.valid?
    # render :new
    user = User.from_omniauth(env["omniauth.auth"])
    session[:current_user_id] = user.id
    redirect_to root_url, notice: "Welcome back, #{user.name}!"
  end

  def failure
    flash[:error] = "Authentication failed, please try again."
    redirect_to root_url, action: :index
  end

  def destroy
    session.delete :current_user_id
    flash[:notice] = "You've logged out."
    redirect_to root_url, action: :index
  end

  private
  def session_params
    params.require(:user).permit(:login, :password)
  end
end
