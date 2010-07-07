require 'test_helper'

class CustomPagesTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CustomPages.new.valid?
  end
end
