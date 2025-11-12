require "test_helper"

class Core::OperatingSystemTest < ActiveSupport::TestCase
  test "has operating system" do
    Core::OperatingSystem.first
    assert :success
  end
end
