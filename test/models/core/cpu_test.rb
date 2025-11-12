require "test_helper"

class Core::CpuTest < ActiveSupport::TestCase
  test "has cpu" do
    Core::Cpu.first
    assert :success
  end
end
