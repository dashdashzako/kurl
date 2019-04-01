require 'test_helper'

class Api::V1::UrlsControllerTest < ActionDispatch::IntegrationTest

  HFA_URL = 'https://highflyers.agency/'
  USERNAME = 'john'
  PASSWORD = 'nobody'

  test 'should post create url' do
    url = { original: HFA_URL }
    records_length = Url.all.length

    post api_v1_urls_url, params: { url: url }, as: :json

    assert_equal records_length + 1, Url.all.length
    assert_response :success
  end

  test 'should destroy only if user is the owner' do
    user = User.create(username: USERNAME, password: PASSWORD)
    user.urls.create(original: HFA_URL)
    authorized_url = user.urls.first

    anonymous_url = Url.create(original: HFA_URL)

    post api_v1_login_url, params: { username: USERNAME, password: PASSWORD }, as: :json
    token = JSON.parse(response.body)['token']

    delete api_v1_url_url(id: anonymous_url.id), headers: { 'Authorization': token }
    assert_response :unauthorized

    delete api_v1_url_url(id: authorized_url.id), headers: { 'Authorization': token }
    assert_response :no_content
  end

  test 'should get and redirect' do
    url = Url.create(original: HFA_URL)
    get "/#{url.short}"
    assert_response :redirect
  end

  test 'should get return an not found error if provided shortcode is not valid' do
    Url.destroy_all
    get '/hello'
    assert_response :not_found
  end
end
