require "test_helper"

class Core::FilesystemTest < ActiveSupport::TestCase
  test "has filesystem" do
    Core::Filesystem.first
    assert :success
  end
end
