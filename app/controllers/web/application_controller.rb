class Web::ApplicationController < ApplicationController
  def access_denied exception
    redirect_to root_url, flash: {error: exception.message}
  end
end
