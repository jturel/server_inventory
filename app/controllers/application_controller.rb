class ApplicationController < ActionController::API
  rescue_from ActionController::BadRequest, with: :bad_request

  def bad_request(error)
    render json: { error: error.message }, status: :bad_request
  end
end
