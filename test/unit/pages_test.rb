require 'test_helper'

class PagesTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Pages.new.valid?
  end
end
