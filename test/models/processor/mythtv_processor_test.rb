require "test_helper"

class Processor::MythtvProcessorTest < ActiveSupport::TestCase
  test "empty database data" do
    mj = file_fixture("mythtv.json").read
    m = JSON.parse(mj)
    m["features"]["database"] = {}
    p = Processor::MythtvProcessor.new
    assert p.process_mythtv_database!(m).nil?
  end
  test "no database data" do
    mj = file_fixture("mythtv.json").read
    m = JSON.parse(mj)
    m["features"].delete("database")
    p = Processor::MythtvProcessor.new
    assert p.process_mythtv_database!(m).nil?
  end
end
