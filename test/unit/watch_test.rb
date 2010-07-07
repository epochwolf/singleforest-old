require 'test_helper'

class WatchTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Watch.new.valid?
  end
end
