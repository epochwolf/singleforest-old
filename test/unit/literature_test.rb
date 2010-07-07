require 'test_helper'

class LiteratureTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Literature.new.valid?
  end
end
