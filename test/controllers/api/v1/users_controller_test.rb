require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get an error trying to access a user whithout authentication' do
    get api_v1_user_url(username: 'ddz')
    assert_response :unauthorized
  end

  test 'authenticated user should only get their own data' do
    username = 'john'
    password = 'nobody'
    User.create(username: username, password: password)

    post api_v1_login_url, params: { username: username, password: password }, as: :json
    token = JSON.parse(response.body)['token']
    refute_nil token

    get api_v1_user_url(username: "#not-{username}"), headers: { 'Authorization': token }
    assert_response :unauthorized

    get api_v1_user_url(username: username), headers: { 'Authorization': token }
    assert_response :success
  end
end
