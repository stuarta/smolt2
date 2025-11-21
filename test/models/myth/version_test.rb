require "test_helper"

class Myth::VersionTest < ActiveSupport::TestCase
  test "mythtv version bucket handline" do
    dbv = Myth::Version.find_or_create_by(version: "v31.0+fixes.202203040618.7e4ce1ba98~ubuntu20.04.1")
    assert dbv.version_bucket == "v31.0"
  end
end
