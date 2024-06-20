class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload[:user_id]) if session[:user_id]
  end

  def not_authorized
    render json: { errors: ['Not authorized'] }, status: :unauthorized
  end
end
