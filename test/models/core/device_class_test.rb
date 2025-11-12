require "test_helper"

class Core::DeviceClassTest < ActiveSupport::TestCase
  test "has device class" do
    Core::DeviceClass.first
    assert :success
  end
end
