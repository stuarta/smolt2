require "test_helper"

class Core::VendorTest < ActiveSupport::TestCase
  test "has vendor" do
    Core::Vendor.first
    assert :success
  end
end
