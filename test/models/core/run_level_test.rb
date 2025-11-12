require "test_helper"

class Core::RunLevelTest < ActiveSupport::TestCase
  test "has runlevel" do
    Core::RunLevel.first
    assert :success
  end
end
