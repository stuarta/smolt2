require "test_helper"

class Myth::HostTest < ActiveSupport::TestCase
  test "Myth::Host model" do
    mj = file_fixture("mythtv.json").read
    m = JSON.parse(mj)
    f = m["features"]
    myth_host = Myth::Host.new
    myth_uuid = Myth::Uuid.find_or_create_by(myth_uuid: "#{f["uuid"]}")
    myth_host.uuid_id = myth_uuid.id
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
    f["grabbers"].each do |grabber|
      m_grabber = Myth::Grabber.find_or_create_by(grabber: "#{grabber}")
      myth_host.grabbers << m_grabber
    end
    m_history = Myth::Historical.create(db_age:     f["historical"]["db_age"],
                                        rectime:    f["historical"]["rectime"],
                                        reccount:   f["historical"]["reccount"],
                                        showcount:  f["historical"]["showcount"])
    myth_host.historical_id = m_history.id
    f["recordings"].each do |r_name, r_stat|
      m_recstat = Myth::Recording.create(name:  r_name,
                                         count: r_stat["count"],
                                         time:  r_stat["time"])
      if r_stat.key?("size")
        m_recstat["size"] = r_stat["size"]
      end
      if m_recstat.valid?
        myth_host.recordings << m_recstat
      end
    end
    # Scheduler, optional
    if not f["scheduler"].empty?
      m_scheduler = Myth::Scheduler.create(count:         f["scheduler"]["count"],
                                           match_avg:     f["scheduler"]["match_avg"],
                                           match_stddev:  f["scheduler"]["match_scheduler"],
                                           place_avg:     f["scheduler"]["place_avg"],
                                           place_stddev:  f["scheduler"]["place_stddev"])
      myth_host.scheduler = m_scheduler
    end
    f["storage"].each do |s_name, s_size|
      m_storage = Myth::Storage.create(name: s_name, size: s_size)
      myth_host.storages << m_storage
    end
    f["tuners"].each do |t_name, t_count|
      m_tuner = Myth::Tuner.create(name: t_name, tuner_count: t_count)
      myth_host.tuners << m_tuner
    end

    assert myth_host.valid?
  end
end
