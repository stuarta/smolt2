class Processor::HostProcessor
  def process_host(host_raw)
    host = JSON.parse(host_raw.data)
    host["distro_specific"]["mythtv"]["arrival"] = host_raw.arrival
    Rails.logger.debug "Processing host #{host["uuid"]}"
    hpm = Core::HostPubMapping.find_or_create_by(uuid: host["uuid"])
    h = Core::Host.find_by(host_pub_mapping_id: hpm.id)
    if h.nil?
      # Create Host entry
      Rails.logger.info "New host entry for #{host["uuid"]} will be created"
      h = Core::Host.new(
        updated_at:       host_raw.arrival,
        bogomips:         host["bogomips"],
        system:           host["system"],
        system_memory:    host["system_memory"],
        system_swap:      host["system_swap"],
        num_cpus:         host["num_cpus"],
        cpu_speed:        host["cpu_speed"],
        selinux_enabled:  host["selinux_enabled"],
        selinux_policy:   host["selinux_policy"],
        selinux_enforce:  host["selinux_enforce"],
      )
    else
      Rails.logger.info "Existing host entry for #{host["uuid"]} will be updated"
      h.devices.delete_all
      h.file_systems.delete_all
    end
    begin
      cpu = Core::Cpu.find_or_create_by!(
        cpu_family:     host["cpu_family"],
        cpu_stepping:   host["cpu_stepping"],
        cpu_model_num:  host["cpu_model_num"],
        cpu_vendor:     host["cpu_vendor"],
        cpu_model:      host["cpu_model"]
      )
      ff = Core::Formfactor.find_or_create_by!(formfactor: host["formfactor"])
      k_ver = Core::KernelVersion.find_or_create_by!(kernel_version: host["kernel_version"])
      platform = Core::Platform.find_or_create_by!(platform: host["platform"])
      vendor = Core::Vendor.find_or_create_by!(name: host["vendor"])
      runlevel = Core::RunLevel.find_or_create_by!(default_runlevel: host["default_runlevel"])
      if host["os"].nil? or host["os"].length > 255 # too big, bad data
        operating_system = Core::OperatingSystem.find_or_create_by!(os: "unknown")
      else
        operating_system = Core::OperatingSystem.find_or_create_by!(os: host["os"])
      end
      language = Core::Language.find_or_create_by!(language: host["language"])
    rescue ActiveRecord::RecordNotUnique
      retry
    end
    h.host_pub_mapping_id = hpm.id
    h.cpu_id = cpu.id
    h.formfactor_id = ff.id
    h.kernel_version_id = k_ver.id
    h.platform_id = platform.id
    h.vendor_id = vendor.id
    h.run_level_id = runlevel.id
    h.operating_system_id = operating_system.id
    h.language_id = language.id
    # Create Devices and link back to host
    host["devices"].each do |device|
      devp = Processor::DeviceProcessor.new
      dev = devp.find_or_create_device!(device)
      if not dev.nil?
        h.devices << dev
      end
    end
    # Process filesystems
    host["fss"].each do |fs|
      if fs["mnt_pnt"] != "WITHHELD"
        h.file_systems.build(
          mnt_pnt: fs["mnt_pnt"],
          fs_type: fs["fs_type"],
          f_bavail: fs["f_favail"],
          f_bsize: fs["f_bsize"],
          f_frsize: fs["f_frsize"],
          f_blocks: fs["f_blocks"],
          f_bfree: fs["f_bfree"],
          f_files: fs["f_files"],
          f_ffree: fs["f_ffree"],
          f_fssize: fs["f_fssize"],
        )
      end
    end
    # Process MythTV specific data
    m = Processor::MythtvProcessor.new
    myth_host = m.process_mythtv!(h, host["distro_specific"]["mythtv"])
    h.myth_host_id = myth_host.id
    Rails.logger.debug "Reached the end of processing"

    h.save!
    # Return host object
    h
  end
end
