require "test_helper"

class Myth::HostTest < ActiveSupport::TestCase
  test "Myth::Database model" do
    mj = file_fixture("mythtv.json").read
    m = JSON.parse(mj)
    f = m["features"]
    myth_host = Myth::Host.new
    mb = Myth::Branch.find_or_create_by(branch: "#{f["branch"]}")
    myth_host.branch_id = mb.id
    ml = Myth::Language.find_or_create_by(language: "#{f["language"]}")
    myth_host.language_id = ml.id
    m_libapi = Myth::Libapi.find_or_create_by(libapi: "#{f["libapi"]}")
    myth_host.libapi_id = m_libapi.id
    m_theme = Myth::Theme.find_or_create_by(theme: "#{f["theme"]}")
    myth_host.theme_id = m_theme.id
    m_tz = Myth::Timezone.find_or_create_by(timezone: "#{f["timezone"]}")
    myth_host.timezone_id = m_tz.id
    m_country = Myth::Country.find_or_create_by(country: "#{f["country"]}")
    myth_host.country_id = m_country.id
    m_ver = Myth::Version.find_or_create_by(version: "#{f["version"]}")
    myth_host.version_id = m_ver.id
    m_vb = Myth::VersionBucket.find_or_create_by(version_bucket: "#{m_ver.version_bucket}")
    myth_host.version_bucket_id = m_vb.id
    m_qt_version = Myth::QtVersion.find_or_create_by(qt_version: "#{f["qtversion"]}")
    myth_host.qt_version_id = m_qt_version.id
    myth_host.channelcount = f["channel_count"]
    myth_host.sourcecount = f["sourcecount"]
    m_remote = Myth::Remote.find_or_create_by(remote: "#{f["remote"]}")
    myth_host.remote_id = m_remote.id
    m_protocol = Myth::Protocol.find_or_create_by(protocol: "#{f["protocol"]}")
    myth_host.protocol_id = m_protocol.id
    m_tzoffset = Myth::Tzoffset.find_or_create_by(tzoffset: "#{f["tzoffset"]}")
    myth_host.tzoffset_id = m_tzoffset.id
    myth_host.vtpertuner = f["vtpertuner"]
    assert myth_host.save
  end
end
