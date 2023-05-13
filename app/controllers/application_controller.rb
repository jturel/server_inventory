class ApplicationController < ActionController::API
  rescue_from StandardError do |error|
    render json: { error: error.message }, status: :internal_server_error
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: { error: error.message }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { error: error.message }, status: :not_found
  end
end
