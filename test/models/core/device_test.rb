require "test_helper"

class Core::DeviceTest < ActiveSupport::TestCase
  test "has bus" do
    Core::Device.first
    assert :success
  end
end
