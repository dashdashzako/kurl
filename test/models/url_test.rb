require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  def setup
    @url = urls(:ddz)
  end

  test 'valid url' do
    assert @url.valid?
  end

  test 'invalid when original format is not recognized' do
    @url.original = nil
    refute @url.valid?
    @url.original = ''
    refute @url.valid?
    @url.original = 'highflyers.agency'
    refute @url.valid?
    @url.original = 'http://.agency'
    refute @url.valid?
    @url.original = 'http://highflyers'
    refute @url.valid?
    @url.original = 'ftp://highflyers.agency'
    refute @url.valid?
    @url.original = 'highflyers.agency'
    refute @url.valid?
  end

  test 'valid when original format is recognized' do
    @url.original = 'http://highflyers.agency/'
    assert @url.valid?
    @url.original = 'http://highflyers.agency'
    assert @url.valid?
    @url.original = 'https://highflyers.agency'
    assert @url.valid?
    @url.original = 'https://www.highflyers.agency/post/47'
    assert @url.valid?
    @url.original = 'https://www.highflyers.agency/post/47?this=is&yet=another%20query'
    assert @url.valid?
  end

  test 'invalid without expiration date' do
    @url.expires_at = nil
    refute @url.valid?
    assert_not_nil @url.errors[:expires_at]
  end

  test 'invalid without short url' do
    @url.short = nil
    refute @url.valid?
    assert_not_nil @url.errors[:short]
  end
end
