require "test_helper"

class Core::DeviceTest < ActiveSupport::TestCase
  test "handle invalid device" do
    device = { "description" => "Unknown",
                  "type" => nil,
                  "bus" => "USB",
                  "subsys_vendor_id" => nil,
                  "vendor_id" => 7531,
                  "driver" => "None",
                  "subsys_device_id" => nil,
                  "device_id" => nil }
    devp = Processor::DeviceProcessor.new
    dev = devp.find_or_create_device!(device)
    assert dev.nil?
  end
end
