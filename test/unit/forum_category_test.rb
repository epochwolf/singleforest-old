require 'test_helper'

class ForumCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ForumCategory.new.valid?
  end
end
