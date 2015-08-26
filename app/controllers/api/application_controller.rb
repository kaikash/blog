class Api::ApplicationController < ApplicationController
  def access_denied exception
    render json: {error: 1, error_message: exception.message}, status: 403
  end
end
