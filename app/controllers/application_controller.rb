class ApplicationController < ActionController::API

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = AuthToken.decode(header)
      @current_user = User.find_by!(id: @decoded[:user_id], username: params[:username])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      # here
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
