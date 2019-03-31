require 'test_helper'

class UrlAnalyticTest < ActiveSupport::TestCase
  test 'should validate and create a url analytic' do
    UrlAnalytic.destroy_all
    url = Url.create(original: 'https://highflyers.agency')
    url.url_analytics.create()
    assert_equal 1, UrlAnalytic.count
  end

  test 'should not validate' do
    url_analytic = UrlAnalytic.new
    refute url_analytic.valid?
  end

  test 'should cascade url destroy' do
    UrlAnalytic.destroy_all
    url = Url.create(original: 'https://highflyers.agency')
    url.url_analytics.create()
    url.url_analytics.create()
    assert_equal 2, UrlAnalytic.count
    url.destroy
    assert_equal 0, UrlAnalytic.count
  end
end
