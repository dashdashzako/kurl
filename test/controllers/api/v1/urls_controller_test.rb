require 'test_helper'

class Api::V1::UrlsControllerTest < ActionDispatch::IntegrationTest

  HFA = 'https://highflyers.agency/'
  USERNAME = 'john'
  PASSWORD = 'nobody'

  test 'should post create url' do
    url = { original: HFA }
    records_length = Url.all.length

    post api_v1_urls_url, params: { url: url }, as: :json

    assert_equal records_length + 1, Url.all.length
    assert_response :success
  end

  test 'should destroy only if user is the owner' do
    user = User.create(username: USERNAME, password: PASSWORD)
    user.urls.create(original: HFA)
    authorized_url = user.urls.first

    anonymous_url = Url.create(original: 'https://dashdashzako.net')

    post api_v1_login_url, params: { username: USERNAME, password: PASSWORD }, as: :json
    token = JSON.parse(response.body)['token']

    delete api_v1_url_url(id: anonymous_url.id), headers: { 'Authorization': token }
    assert_response :unauthorized

    delete api_v1_url_url(id: authorized_url.id), headers: { 'Authorization': token }
    assert_response :no_content
  end
end
