class Web::SessionController < Web::ApplicationController
  before_filter :authed_closed, except: :destroy

  # GET /web/session/new
  def new
    @user = UserForm.new
  end

  # POST /web/session
  def create
    @user = UserForm.new session_params
    if user = @user.save
      session[:current_user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}!"
      return redirect_to controller: 'web/articles', action: :index
    end
    flash[:error] = "Password or login is incorrect" if @user.valid?
    render :new
  end

  def destroy
    session.delete :current_user_id
    flash[:notice] = "You've logged out."
    redirect_to controller: 'web/articles', action: :index
  end

  private
  def session_params
    params.require(:user).permit(:login, :password)
  end
end
