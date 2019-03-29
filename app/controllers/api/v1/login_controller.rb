class Api::V1::LoginController < ApplicationController

  # POST /api/v1/login
  def create
    @user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    if @user
      token_expiration = Time.now + 24.hours.to_i
      payload = { user_id: @user.id }
      token = AuthToken.encode payload

      render json: { token: token, username: @user.username }, status: :ok
    else
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end
end
