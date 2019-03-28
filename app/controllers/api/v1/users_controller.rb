class Api::V1::UsersController < ApplicationController
  before_action :authorize_request

  # GET /api/v1/users/{username}
  def show
    render json: @current_user
  end
end
