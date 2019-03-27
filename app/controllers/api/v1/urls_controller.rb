require 'securerandom'

class Api::V1::UrlsController < ApplicationController
  before_action :set_url, only: [:show, :update, :destroy]

  # GET urls
  def index
    render json: Url.all
  end

  # GET /urls/1
  def show
    render json: @url
  end

  # POST /urls
  def create
    @url = Url.new(url_params)
    @url.short = SecureRandom.hex(3)
    @url.expires_at = 3.days.from_now

    if @url.save
      redirect_to api_v1_url_url(@url)
    else
      render json: { errors: @url.errors.full_messages }, status: 422
    end
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end

  def set_url
    @url = Url.find(params[:id])
  end
end
