require "test_helper"

class Core::HostTest < ActiveSupport::TestCase
  test "has host" do
    Core::Host.first
    assert :success
  end
end
