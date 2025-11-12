require "test_helper"

class Core::DeviceLinkTest < ActiveSupport::TestCase
  test "has device link" do
    Core::DeviceLink.first
    assert :success
  end
end
