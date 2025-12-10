class Processor::MythtvProcessor
  def process_mythtv!(host, mythtv_data)
    # Add current time to data so it's consistent across all tables
    mythtv_data["last_modified"] = DateTime.now
    myth_uuid_data = mythtv_data["features"]["uuid"]
    Rails.logger.info("Handling MythTV uuid: #{myth_uuid_data}")
    if Myth::Uuid.exists?(myth_uuid: "#{myth_uuid_data}")
      Rails.logger.info("* removing existing record")
      u = Myth::Uuid.find_by(myth_uuid: "#{myth_uuid_data}")
      Myth::Host.destroy_by(uuid_id: u.id)
    else
      Rails.logger.info("* new mythtv uuid")
    end
    myth_uuid = Myth::Uuid.find_or_create_by(myth_uuid: "#{myth_uuid_data}")

    process_mythtv_host!(myth_uuid, mythtv_data)
  end

  def process_mythtv_host!(myth_uuid, mythtv_data)
    f = mythtv_data["features"]
    myth_host = Myth::Host.new
    myth_host.uuid_id = myth_uuid.id
    myth_host.arrival = mythtv_data["arrival"]
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

    # Grabbers
    if f.key?("grabbers")
      f["grabbers"].each do |grabber|
        m_grabber = Myth::Grabber.find_or_create_by(grabber: "#{grabber}")
        myth_host.grabbers << m_grabber
      end
    end

    # Historical Data, optional
    if f.key?("historical")
      m_history = Myth::Historical.create(db_age:     f["historical"]["db_age"],
                                          rectime:    f["historical"]["rectime"],
                                          reccount:   f["historical"]["reccount"],
                                          showcount:  f["historical"]["showcount"])
      myth_host.historical_id = m_history.id
    end

    # Recordings, optional
    if f.key?("recordings")
      f["recordings"].each do |r_name, r_stat|
        m_recstat = Myth::Recording.create(name: r_name,
                                          count: r_stat["count"],
                                          time:  r_stat["time"])
        if r_stat.key?("size")
          m_recstat["size"] = r_stat["size"]
        end
        if m_recstat.valid? # trigger validations so we can avoid bad data
          myth_host.recordings << m_recstat
        end
      end
    end

    # Scheduler, optional
    if f.key?("scheduler") and not f["scheduler"].empty?
      m_scheduler = Myth::Scheduler.create(count:         f["scheduler"]["count"],
                                           match_avg:     f["scheduler"]["match_avg"],
                                           match_stddev:  f["scheduler"]["match_stddev"],
                                           place_avg:     f["scheduler"]["place_avg"],
                                           place_stddev:  f["scheduler"]["place_stddev"])
      myth_host.scheduler = m_scheduler
    end
    # Storage, optional
    if f.key?("storage")
      f["storage"].each do |s_name, s_size|
        m_storage = Myth::Storage.create(name: s_name, size: s_size)
        myth_host.storages << m_storage
      end
    end

    # Tuners
    if f.key?("tuners")
      f["tuners"].each do |t_name, t_count|
        m_tuner = Myth::Tuner.create(name: t_name, tuner_count: t_count)
        myth_host.tuners << m_tuner
      end
    end

    myth_host.audio = process_mythtv_audio!(mythtv_data)
    myth_host.database = process_mythtv_database!(mythtv_data)
    myth_host.playback_profile = process_mythtv_pbp!(mythtv_data)

    myth_host.save!
    # Return MythtvHost object
    myth_host
  end

  def process_mythtv_audio!(mythtv_data)
    mythtv_audio = mythtv_data["features"]["audio"]
    return if mythtv_audio.nil? or mythtv_audio.empty?
    m_audio = Myth::Audio.new
    m_audio.audio_sys = mythtv_audio["audio_sys"]
    m_audio.audio_sys_version = mythtv_audio["audio_sys_version"]
    m_audio.defaultupmix = mythtv_audio["defaultupmix"]
    m_audio.device = mythtv_audio["device"]
    m_audio.jack = mythtv_audio["jack"]
    m_audio.maxchannels = mythtv_audio["maxchannels"]
    m_audio.mixercontrol = mythtv_audio["mixercontrol"]
    m_audio.mixerdevice = mythtv_audio["mixerdevice"]
    m_audio.passthru = mythtv_audio["passthru"]
    m_audio.passthrudevice = mythtv_audio["passthroughdevice"]
    m_audio.passthruoverride = mythtv_audio["passthroughoverride"]
    m_audio.pulse = mythtv_audio["pulse"]
    m_audio.sr_override = mythtv_audio["sr_override"]
    m_audio.stereopcm = mythtv_audio["stereopcm"]
    m_audio.upmixtype = mythtv_audio["upmixtype"]
    m_audio.volcontrol = mythtv_audio["volcontrol"]
    # Return Myth::Audio object
    m_audio
  end

  def process_mythtv_database!(mythtv_data)
    db = mythtv_data["features"]["database"]
    return nil if db.nil? or db.empty?
    myth_db = Myth::Database.new

    db["schema"].each do |sk, sv|
      skv = Myth::Schemaversion.find_or_create_by(name: "#{sk}", version: "#{sv}")
      myth_db.schemaversions<<skv
    end

    db["engines"].each do |sv|
      ev = Myth::DbEngine.find_or_create_by(engine: "#{sv}")
      myth_db.db_engines<<ev
    end

    ev = Myth::DbEngine.find_or_create_by(engine: db["usedengine"])
    myth_db.used_engine=ev

    dbv = Myth::DbVersion.find_or_create_by(version: db["version"])
    myth_db.db_version_id = dbv.id

    # Return Myth::Database object
    myth_db
  end

  def process_mythtv_pbp!(mythtv_data)
    mythtv_playback_profile = mythtv_data["features"]["playbackprofile"]
    return if mythtv_playback_profile.nil? or mythtv_playback_profile.empty?
    pbp = Myth::PlaybackProfile.new
    pbp.profile_name = pbp["name"]
    mythtv_playback_profile["profiles"].each do |p|
      pbp_details = Myth::PlaybackProfileDetail.find_or_create_by(decoder: "#{p["decoder"]}",
                                                         deint_pri: "#{p["deint_pri"]}",
                                                         deint_sec: "#{p["deint_sec"]}",
                                                         renderer: "#{p["renderer"]}",
                                                         filters: "#{p["filters"]}")
      pbp.playback_profile_details << pbp_details
    end

    # Return Myth::PlaybackProfile object
    pbp
  end
end
