require 'test_helper'

class Api::V1::UrlsControllerTest < ActionDispatch::IntegrationTest

  test 'should post create url' do
    url = { original: 'https://highflyers.agency/' }
    records_length = Url.all.length

    post api_v1_urls_url, params: { url: url }, as: :json

    assert_equal records_length + 1, Url.all.length
    assert_response :success
  end
end
