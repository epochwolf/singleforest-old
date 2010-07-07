require 'test_helper'

class CollectionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Collection.new.valid?
  end
end
