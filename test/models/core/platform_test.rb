require "test_helper"

class Core::PlatformTest < ActiveSupport::TestCase
  test "has platform" do
    Core::Platform.first
    assert :success
  end
end
