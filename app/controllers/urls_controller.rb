require 'securerandom'

class UrlsController < ApplicationController
  def index
    render json: Url.all
  end

  def show
    @url = Url.find(params[:id])
    render json: @url
  end

  def create
    @url = Url.new(url_params)
    @url.short = SecureRandom.hex(3)
    @url.expires_at = 3.days.from_now
 
    @url.save
    redirect_to @url
  end

  private
  
  def url_params
    params.require(:url).permit(:original)
  end
end
