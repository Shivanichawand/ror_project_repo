class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authorize_request

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = JsonWebToken.decode(header) rescue nil
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
    render json: { errors: ['Unauthorized'] }, status: :unauthorized unless @current_user
  end
end
