require 'test_helper'

class CommentsTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Comments.new.valid?
  end
end
