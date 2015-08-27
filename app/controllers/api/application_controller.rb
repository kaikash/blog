class Api::ApplicationController < ApplicationController
  def access_denied exception
    render json: {error: 1, error_message: exception.message}, status: 403
  end

  def render_not_found
    render json: {error: 1, error_message: "Not found"}, status: 404
  end

  def render_error exception
    render json: {error: 1, error_message: exception.message}, status: 500
  end
end
