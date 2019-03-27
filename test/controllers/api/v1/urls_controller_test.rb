require 'test_helper'

class Api::V1::UrlsControllerTest < ActionDispatch::IntegrationTest
  fixtures :all

  test 'should route to show' do
    assert_routing '/api/v1/urls/1', format: :json, controller: 'api/v1/urls', action: 'show', id: '1'
  end

  test 'should get show url' do
    get '/api/v1/urls/1'
    assert_response :success
  end

  test 'should post create url' do
    url = {
      original: 'https://highflyers.agency/'
    }
    
    post '/api/v1/urls', params: { url: url }, as: :json
    
    assert_equal 4, Url.all.length
    assert_response :redirect
  end
end
