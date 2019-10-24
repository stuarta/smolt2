class Processor::HostProcessor
  def process_host(host_raw)
    ActiveRecord::Base.transaction do
      ts = DateTime.now
      host = JSON.parse(host_raw)
      Rails.logger.debug "Processing host #{host["uuid"]}"
      # Create Host entry
      h = Legacy::Host.find_by_uuid(host["uuid"])
      if h.nil?
        mapper = Core::HostPubMapping.new
        pub_uuid = mapper.get_pub_uuid(host["uuid"])
        h = Legacy::Host.new(
          uuid:             host["uuid"],
          pub_uuid:         pub_uuid,
          last_modified:    ts,
          rating:           0,
          selinux_enabled:  host["selinux_enabled"]
        )
        Core::HostPubMapping.where(:uuid => host[:uuid]).destroy_all
      end
      h.update(
        os:               host["os"],
        platform:         host["platform"],
        bogomips:         host["bogomips"],
        system_memory:    host["system_memory"],
        system_swap:      host["system_swap"],
        vendor:           host["vendor"],
        system:           host["system"],
        cpu_vendor:       host["cpu_vendor"],
        cpu_model:        host["cpu_model"],
        num_cpus:         host["num_cpus"],
        cpu_speed:        host["cpu_speed"],
        language:         host["language"],
        default_runlevel: host["default_runlevel"],
        kernel_version:   host["kernel_version"],
        formfactor:       host["formfactor"],
        last_modified:    ts,
        selinux_enabled:  host["selinux_enabled"],
        selinux_policy:   host["selinux_policy"],
        selinux_enforce:  host["selinux_enforce"],
        cpu_stepping:     host["cpu_stepping"],
        cpu_family:       host["cpu_family"],
        cpu_model_num:    host["cpu_model_num"],
      )
      h.save!
      # Create Devices and link back to host
      host["devices"].each do |device|
        devp = Processor::DeviceProcessor.new
        dev = devp.find_or_create_device!(device)
        link = Legacy::HostLink.find_or_create_by!(host: h, device: dev)
      end
      # Process filesystems
      host["fss"].each do |fs|
        f = Processor::FileSystemProcessor.new
        f.process_filesystem!(h, fs)
      end
      # Process MythTV specific data
      m = Processor::MythtvProcessor.new
      m.process_mythtv!(h, host["distro_specific"]["mythtv"])
      Rails.logger.debug "Reached the end of processing"

      # Return host object
      h
    end
  end
end
