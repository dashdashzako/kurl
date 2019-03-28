class Api::V1::UsersController < ApplicationController
  before_action :authorize_request

  # GET /api/v1/users/{username}
  def show
    if params[:username] == @current_user.username
      render json: @current_user.to_json(include: :urls)
    else
      render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  end
end
