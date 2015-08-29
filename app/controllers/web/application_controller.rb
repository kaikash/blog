class Web::ApplicationController < ApplicationController
  def access_denied exception
    redirect_to root_url, flash: {error: exception.message}
  end

  def render_not_found
    render plain: "Not found!", status: 404
  end

  def render_error exception
    render plain: exception.message, status: 500
  end

  def omniauth_failure
    redirect_to root_url, flash: {error: "Authentication failed, please try again."}
  end
end
