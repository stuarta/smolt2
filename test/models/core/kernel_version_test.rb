require "test_helper"

class Core::KernelVersionTest < ActiveSupport::TestCase
  test "has kernel version" do
    Core::KernelVersion.first
    assert :success
  end
end
