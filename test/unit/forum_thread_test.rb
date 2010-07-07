require 'test_helper'

class ForumThreadTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ForumThread.new.valid?
  end
end
