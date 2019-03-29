require 'test_helper'

class Api::V1::LoginControllerTest < ActionDispatch::IntegrationTest

  test 'should post invalid data and return an unauthorized code' do
    post api_v1_login_url, params: { dummy_field: 'not_a_user' }, as: :json
    assert_response :unauthorized
    post api_v1_login_url, params: nil, as: :json
    assert_response :unauthorized
  end

  test 'should post valid data and return an unauthorized code' do
    User.delete_all
    post api_v1_login_url, params: { username: 'not_a_user', password: 'not_a_password' }, as: :json
    assert_response :unauthorized
  end

  test 'should post valid data and return an success code' do
    username = 'john'
    password = 'nobody'
    User.create(username: username, password: password)

    post api_v1_login_url, params: { username: username, password: password }, as: :json
    assert_response :success
  end
end
