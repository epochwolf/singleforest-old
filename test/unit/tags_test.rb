require 'test_helper'

class TagsTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Tags.new.valid?
  end
end
