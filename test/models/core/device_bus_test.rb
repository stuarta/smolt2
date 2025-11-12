require "test_helper"

class Core::DeviceBusTest < ActiveSupport::TestCase
  test "has device bus" do
    Core::DeviceBus.first
    assert :success
  end
end
