require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  def setup
    @url = urls(:ddz)
  end

  test 'valid url' do
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
