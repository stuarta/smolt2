require "test_helper"

class Myth::VersionTest < ActiveSupport::TestCase
  test "mythtv version bucket handling with plus sign" do
    dbv = Myth::Version.find_or_create_by(version: "v31.0+fixes.202203040618.7e4ce1ba98~ubuntu20.04.1")
    assert dbv.version_bucket == "v31.0"
  end
  test "mythtv version bucket handling with dashes" do
    dbv = Myth::Version.find_or_create_by(version: "v36-Pre-492-gefe751de78")
    assert dbv.version_bucket == "v36"
  end
  test "mythtv version bucket handling with squiggle" do
    dbv = Myth::Version.find_or_create_by(version: "v36.0~master.202508230548.20c2b86196~ubuntu25.04.1")
    assert dbv.version_bucket == "v36.0"
  end
end
