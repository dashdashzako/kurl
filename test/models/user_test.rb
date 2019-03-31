require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
  end

  test 'should validate and create a user' do
    @user.username = 'john'
    @user.password = 'nobody'
    assert @user.valid?
    @user.save
    refute_nil @user.id
  end

  test 'should not validate user' do
    refute @user.valid?
    @user.username = 'jo'
    @user.password = 'nobody'
    assert_not_nil @user.errors[:username]
    @user.username = 'john'
    @user.password = 'nobod'
    assert_not_nil @user.errors[:password]
  end

  test 'user should be able to create urls' do
    @user.username = 'john'
    @user.password = 'nobody'
    @user.save

    assert_equal 0, @user.urls.length
    assert_equal 0, Url.where(user_id: @user.id).length

    @user.urls.create(original: 'https://highflyers.agency')
    assert_equal 1, Url.where(user_id: @user.id).length

    url = Url.new(original: 'https://dashdashzako.net')
    url.user = @user
    url.save
    assert_equal 2, Url.where(user_id: @user.id).length

    @user.reload
    assert_equal 2, @user.urls.length
  end

  test 'should cascade user destroy' do
    User.destroy_all
    Url.destroy_all
    UrlAnalytic.destroy_all

    @user.username = 'john'
    @user.password = 'nobody'
    @user.save

    url = @user.urls.create(original: 'https://highflyers.agency')
    assert_equal 1, @user.urls.length
    url.url_analytics.create()
    url.url_analytics.create()
    assert_equal 2, url.url_analytics.length

    @user.destroy
    assert_equal 0, User.count
    assert_equal 0, Url.count
    assert_equal 0, UrlAnalytic.count
  end
end
