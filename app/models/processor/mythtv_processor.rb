class Processor::MythtvProcessor
  def process_mythtv!(host, mythtv_data)
    # Add current time to data so it's consistent across all tables
    mythtv_data["last_modified"] = DateTime.now

    mythtv_host = process_mythtv_host!(host, mythtv_data)
    process_mythtv_audio!(host, mythtv_host, mythtv_data)
    process_mythtv_database!(host, mythtv_host, mythtv_data)
    process_mythtv_grabbers!(host, mythtv_host, mythtv_data)
    process_mythtv_historical!(host, mythtv_host, mythtv_data)
    process_mythtv_pbp!(host, mythtv_host, mythtv_data)
    process_mythtv_recordings!(host, mythtv_host, mythtv_data)
    process_mythtv_scheduler!(host, mythtv_host, mythtv_data)
    process_mythtv_storage!(host, mythtv_host, mythtv_data)
    process_mythtv_tuners!(host, mythtv_host, mythtv_data)
    process_mythtv_logs!(host, mythtv_host, mythtv_data)
  end

  def process_mythtv_host!(host, mythtv_data)
    mythtv_features = mythtv_data["features"]
    Legacy::MythtvHost.where(host: host).destroy_all
    h = Legacy::MythtvHost.new(
      host:                 host,
      branch:               mythtv_features["branch"],
      myth_uuid:            mythtv_features["uuid"],
      language:             mythtv_features["language"],
      libapi:               mythtv_features["libapi"],
      protocol:             mythtv_data["protocol"],
      sourcecount:          mythtv_features["sourcecount"],
      theme:                mythtv_features["theme"],
      timezone:             mythtv_features["timezone"],
      country:              mythtv_features["country"],
      tzoffset:             mythtv_features["tzoffset"],
      version:              mythtv_features["version"],
      myth_version_bucket:  mythtv_features["version"].split("-")[0],
      qt_version:           mythtv_features["qtversion"],
      channel_count:        mythtv_features["channel_count"],
      remote:               mythtv_features["remote"],
      myth_type:            mythtv_features["mythtype"],
      vtpertuner:           mythtv_features["vtpertuner"],
      last_modified:        mythtv_data["last_modified"],
    )
    h.save!
    # Return MythtvHost object
    h
  end

  def process_mythtv_audio!(host, mythtv_host, mythtv_data)
    mythtv_audio = mythtv_data["features"]["audio"]
    return if mythtv_audio.nil? or mythtv_audio.empty?
    Legacy::MythtvAudio.where(host: host).destroy_all
    a = Legacy::MythtvAudio.new(
      host:               host,
      audio_sys:          mythtv_audio["audio_sys"],
      audio_sys_version:  mythtv_audio["audio_sys_version"],
      device:             mythtv_audio["device"],
      mixercontrol:       mythtv_audio["mixercontrol"],
      mixerdevice:        mythtv_audio["mixerdevice"],
      maxchannels:        mythtv_audio["maxchannels"],
      steropcm:           mythtv_audio["stereopcm"],
      volcontrol:         mythtv_audio["volcontrol"],
      passthru:           mythtv_audio["passthru"][0],
      passthruoverride:   mythtv_audio["passthruoverride"],
      passthrudevice:     mythtv_audio["passthrudevice"],
      sr_override:        mythtv_audio["sr_override"],
      upmixtype:          mythtv_audio["upmixtype"],
      defaultupmix:       mythtv_audio["defaultupmix"],
      jack:               mythtv_audio["jack"],
      pulse:              mythtv_audio["pulse"],
      last_modified:      mythtv_data["last_modified"],
    )
    a.save!
  end

  def process_mythtv_database!(host, mythtv_host, mythtv_data)
    mythtv_database = mythtv_data["features"]["database"]
    return if mythtv_database.empty?
    Legacy::MythtvDatabase.where(mythtv_host: mythtv_host).destroy_all
    d = Legacy::MythtvDatabase.new(
      mythtv_host:    mythtv_host,
      version:        mythtv_database["version"],
      usedengine:     mythtv_database["usedengine"],
      engines:        mythtv_database["engines"],
      schemas:        mythtv_database["schema"],
      last_modified:  mythtv_data["last_modified"],
    )
    d.save!
  end

  def process_mythtv_grabbers!(host, mythtv_host, mythtv_data)
    mythtv_grabbers = mythtv_data["features"]["grabbers"]
    Legacy::MythtvGrabber.where(mythtv_host: mythtv_host).destroy_all
    return if mythtv_grabbers.empty?
    mythtv_grabbers.each do |grabber|
      g = Legacy::MythtvGrabber.new(
        host:           host,
        mythtv_host:    mythtv_host,
        grabber:        grabber,
        last_modified:  mythtv_data["last_modified"],
      )
      g.save!
    end
  end

  def process_mythtv_historical!(host, mythtv_host, mythtv_data)
    mythtv_historical = mythtv_data["features"]["historical"]
    return if mythtv_historical.nil?
    Legacy::MythtvHistorical.where(mythtv_host: mythtv_host).destroy_all
    h = Legacy::MythtvHistorical.new(
      mythtv_host:    mythtv_host,
      db_age:         mythtv_historical["db_age"],
      rectime:        mythtv_historical["rectime"],
      reccount:       mythtv_historical["reccount"],
      showcount:      mythtv_historical["showcount"],
      last_modified:  mythtv_data["last_modified"],
    )
    h.save!
  end

  def process_mythtv_pbp!(host, mythtv_host, mythtv_data)
    mythtv_playback_profile = mythtv_data["features"]["playbackprofile"]
    return if mythtv_playback_profile.nil? or mythtv_playback_profile.empty?
    Legacy::MythtvPlaybackProfile.where(host: host).destroy_all
    pbp = Legacy::MythtvPlaybackProfile.new(
      host:           host,
      mythtv_host:    mythtv_host,
      name:           mythtv_playback_profile["name"],
      profiles:       mythtv_playback_profile["profiles"],
      last_modified:  mythtv_data["last_modified"],
    )
    pbp.save!
  end

  def process_mythtv_recordings!(host, mythtv_host, mythtv_data)
    mythtv_recordings = mythtv_data["features"]["recordings"]
    return if mythtv_recordings.empty?
    Legacy::MythtvRecording.where(mythtv_host: mythtv_host).destroy_all
    r = Legacy::MythtvRecording.new(
      mythtv_host:    mythtv_host,
      sched_count:    mythtv_recordings["scheduled"]["count"],
      sched_time:     mythtv_recordings["scheduled"]["time"],
      sched_size:     mythtv_recordings["scheduled"]["size"],
      live_count:     mythtv_recordings["livetv"]["count"],
      live_time:      mythtv_recordings["livetv"]["time"],
      live_size:      mythtv_recordings["livetv"]["size"],
      exp_count:      mythtv_recordings["expireable"]["count"],
      exp_time:       mythtv_recordings["expireable"]["time"],
      exp_size:       mythtv_recordings["expireable"]["size"],
      upcoming_count: mythtv_recordings["upcoming"]["count"],
      upcoming_time:  mythtv_recordings["upcoming"]["time"],
      last_modified:  mythtv_data["last_modified"],
    )
    r.save!
  end

  def process_mythtv_scheduler!(host, mythtv_host, mythtv_data)
    mythtv_scheduler = mythtv_data["features"]["scheduler"]
    # Handle empty scheduler response
    return if mythtv_scheduler.empty?
    Legacy::MythtvScheduler.where(mythtv_host: mythtv_host).destroy_all
    s = Legacy::MythtvScheduler.new(
      mythtv_host:    mythtv_host,
      count:          mythtv_scheduler["count"],
      match_avg:      mythtv_scheduler["match_avg"],
      match_stddev:   mythtv_scheduler["match_stddev"],
      place_avg:      mythtv_scheduler["place_avg"],
      place_stddev:   mythtv_scheduler["place_stddev"],
      last_modified:  mythtv_data["last_modified"],
    )
    s.save!
  end

  def process_mythtv_storage!(host, mythtv_host, mythtv_data)
    mythtv_storage = mythtv_data["features"]["storage"]
    return if mythtv_storage.nil? or mythtv_storage.empty?
    s = Legacy::MythtvStorage.find_by(mythtv_host: mythtv_host)
    if s.nil?
      s = Legacy::MythtvStorage.new(
        mythtv_host:    mythtv_host,
        last_modified:  mythtv_data["last_modified"],
      )
    end
    s.update(
      recfree:        mythtv_storage["recfree"],
      rectotal:       mythtv_storage["rectotal"],
      videototal:     mythtv_storage["videototal"],
      videofree:      mythtv_storage["videofree"],
      last_modified:  mythtv_data["last_modified"],
    )
    s.save!
  end

  def process_mythtv_tuners!(host, mythtv_host, mythtv_data)
    mythtv_tuners = mythtv_data["features"]["tuners"]
    return if mythtv_tuners.empty?
    Legacy::MythtvTuner.where(mythtv_host: mythtv_host).destroy_all
    mythtv_tuners.each do |tuner_type, tuner_count|
      t = Legacy::MythtvTuner.new(
        mythtv_host:    mythtv_host,
        tuner_type:     tuner_type,
        tuner_count:    tuner_count,
        last_modified:  mythtv_data["last_modified"],
      )
      t.save!
    end
  end

  def process_mythtv_logs!(host, mythtv_host, mythtv_data)
    mythtv_log = mythtv_data["features"]["logurgency"]
    return if mythtv_log.nil? or mythtv_log.empty?
    Legacy::MythtvLog.where(mythtv_host: mythtv_host).destroy_all
    l = Legacy::MythtvLog.new(
      mythtv_host:    mythtv_host,
      crit:           mythtv_log["CRIT"],
      info:           mythtv_log["INFO"],
      notice:         mythtv_log["NOTICE"],
      warning:        mythtv_log["WARNING"],
      err:            mythtv_log["ERR"],
      last_modified:  mythtv_data["last_modified"],
    )
    l.save!
  end
end
