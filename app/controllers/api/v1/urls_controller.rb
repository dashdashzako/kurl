class Api::V1::UrlsController < ApplicationController
  before_action :set_url, only: %i[destroy]
  before_action :set_current_user, only: %i[create]
  before_action :authorize_request, only: %i[destroy]

  # POST /api/v1/urls
  def create
    @url = Url.new(url_params)
    @url.user_id = @current_user.id if @current_user

    if @url.save
      render json: @url
    else
      render json: { errors: @url.errors.full_messages }, status: 422
    end
  end

  # DELETE /api/v1/urls/{id}
  def destroy
    @url.destroy
    head :no_content
  end

  private

  def url_params
    begin
      params.require(:url).permit(:original)
    rescue => exception
      false
    end
  end

  def set_url
    @url = Url.find(params[:id])
  end
end
