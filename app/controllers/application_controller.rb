class ApplicationController < ActionController::API

  def authorize_request
    begin
      header = request.headers['Authorization']
      header = header.split(' ').last if header
      decoded = AuthToken.decode(header)
      @current_user = User.find_by!(id: decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def set_current_user
    header = request.headers['Authorization']
    if header
      header = header.split(' ').last
      decoded = AuthToken.decode(header)
      @current_user = User.find_by(id: decoded[:user_id])
    end
  end
end
