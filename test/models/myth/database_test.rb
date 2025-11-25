require "test_helper"

class Myth::DatabaseTest < ActiveSupport::TestCase
  test "Myth::Database associations" do
    mj = file_fixture("mythtv.json").read
    m = JSON.parse(mj)
    db = m["features"]["database"]
    x = Myth::Database.new

    db["schema"].each do |sk, sv|
      skv = Myth::Schemaversion.find_or_create_by(name: "#{sk}", version: "#{sv}")
      x.schemaversions<<skv
    end

    db["engines"].each do |sv|
      ev = Myth::DbEngine.find_or_create_by(engine: "#{sv}")
      x.db_engines<<ev
    end

    ev = Myth::DbEngine.find_or_create_by(engine: db["usedengine"])
    x.used_engine=ev

    dbv = Myth::DbVersion.find_or_create_by(version: db["version"])
    x.db_version_id = dbv.id

    x.host_id = Myth::Host.first.id
    assert x.save
  end
end
