require "test_helper"

class Core::HostPubMappingTest < ActiveSupport::TestCase
  test "has host pub mapping" do
    Core::HostPubMapping.first
    assert :success
  end
end
