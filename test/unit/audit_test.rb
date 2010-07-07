require 'test_helper'

class AuditTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Audit.new.valid?
  end
end
