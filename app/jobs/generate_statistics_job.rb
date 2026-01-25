class GenerateStatisticsJob < ApplicationJob
  queue_as :solid_queue_recurring

  def perform(*args)
    hosts_recent = Core::Host.recent # Hosts seen recently
    @detailed_stats = {}

    # Platforms (archs)
    @detailed_stats["archs"] = {}
    platform_recent = hosts_recent.map(&:platform_id).uniq
    Core::Platform.find(platform_recent).each do |p|
      @detailed_stats["archs"][p.platform] = hosts_recent.select { |h| h.platform_id == p.id }.count
    end

    # Operating systems
    @detailed_stats["os"] = {}
    os_recent = hosts_recent.map(&:operating_system_id).uniq
    Core::OperatingSystem.find(os_recent).each do |os|
      @detailed_stats["os"][os.os] = hosts_recent.select { |h| h.operating_system_id == os.id }.count
    end

    # Runlevel
    @detailed_stats["runlevel"] = {}
    runlevel_recent = hosts_recent.map(&:run_level_id).uniq
    Core::RunLevel.find(runlevel_recent).each do |rl|
      @detailed_stats["runlevel"][rl.default_runlevel] = hosts_recent.select { |h| h.run_level_id == rl.id }.count
    end

    # Language
    @detailed_stats["language"] = {}
    language_recent = hosts_recent.map(&:language_id).uniq
    Core::Language.find(language_recent).each do |language|
      @detailed_stats["language"][language.language] = hosts_recent.select { |h| h.language_id == language.id }.count
    end

    # Vendors
    @detailed_stats["vendor"] = {}
    vendor_recent = hosts_recent.map(&:vendor_id).uniq
    Core::Vendor.find(vendor_recent).each do |vendor|
      @detailed_stats["vendor"][vendor.name] = hosts_recent.select { |h| h.vendor_id == vendor.id }.count
    end

    # Models
    @detailed_stats["model"] = {}
    model_recent = hosts_recent.map(&:system).uniq
    model_recent.each do |model|
      @detailed_stats["model"][model] = hosts_recent.select { |h| h.system == model }.count
    end

    # RAM
    @detailed_stats["ram"] = {}
    @detailed_stats["ram"]["0_to_2Gb"] = hosts_recent.memory_0_to_2Gb.count
    @detailed_stats["ram"]["2_to_4Gb"] = hosts_recent.memory_2_to_4Gb.count
    @detailed_stats["ram"]["4_to_8Gb"] = hosts_recent.memory_4_to_8Gb.count
    @detailed_stats["ram"]["8_to_16Gb"] = hosts_recent.memory_8_to_16Gb.count
    @detailed_stats["ram"]["16_to_32Gb"] = hosts_recent.memory_16_to_32Gb.count
    @detailed_stats["ram"]["32_to_64Gb"] = hosts_recent.memory_32_to_64Gb.count
    @detailed_stats["ram"]["64_to_128Gb"] = hosts_recent.memory_64_to_128Gb.count
    @detailed_stats["ram"]["128Gb_plus"] = hosts_recent.memory_128Gb_plus.count

    # Swap
    @detailed_stats["swap"] = {}
    @detailed_stats["swap"]["0_to_2Gb"] = hosts_recent.swap_0_to_2Gb.count
    @detailed_stats["swap"]["2_to_4Gb"] = hosts_recent.swap_2_to_4Gb.count
    @detailed_stats["swap"]["4_to_8Gb"] = hosts_recent.swap_4_to_8Gb.count
    @detailed_stats["swap"]["8_to_16Gb"] = hosts_recent.swap_8_to_16Gb.count
    @detailed_stats["swap"]["16_to_32Gb"] = hosts_recent.swap_16_to_32Gb.count
    @detailed_stats["swap"]["32_to_64Gb"] = hosts_recent.swap_32_to_64Gb.count
    @detailed_stats["swap"]["64_to_128Gb"] = hosts_recent.swap_64_to_128Gb.count
    @detailed_stats["swap"]["128Gb_plus"] = hosts_recent.swap_128Gb_plus.count

    # CPU
    @detailed_stats["cpu"] = {}
    @detailed_stats["cpu"]["vendor"] = {}
    cpu_recent = hosts_recent.map(&:cpu_id).uniq
    Core::Cpu.find(cpu_recent).each do |cpu|
      @detailed_stats["cpu"]["vendor"][cpu.cpu_vendor] = hosts_recent.select { |h| h.cpu_id == cpu.id }.count
    end
    @detailed_stats["cpu"]["num_cpus"] = {}
    num_cpus_recent = hosts_recent.map(&:num_cpus).uniq
    num_cpus_recent.each do |num_cpus|
      @detailed_stats["cpu"]["num_cpus"][num_cpus] = hosts_recent.select { |h| h.num_cpus == num_cpus }.count
    end

    # Kernel
    @detailed_stats["kernel"] = {}
    kernel_recent = hosts_recent.map(&:kernel_version_id).uniq
    Core::KernelVersion.find(kernel_recent).each do |kernel|
      @detailed_stats["kernel"][kernel.kernel_version] = hosts_recent.select { |h| h.kernel_version_id == kernel.id }.count
    end

    # Filesystems
    @detailed_stats["filesystems"] = {}
    @detailed_stats["filesystems"]["fs_type"] = {}
    filesystem_recent = Core::Filesystem.where("host_id in (?)", hosts_recent.map(&:id)).map(&:fs_type).uniq
    filesystem_recent.each do |fs_type|
      @detailed_stats["filesystems"]["fs_type"][fs_type] = 0
    end
    hosts_recent.each do |host|
      filesystem_recent.each do |fs_type|
        # for each host, and each recent fs_type count up the occurances
        @detailed_stats["filesystems"]["fs_type"][fs_type] += host.file_systems.select { |fs| fs.fs_type == fs_type }.count
      end
    end
    @detailed_stats["filesystems"]["size_map"] = {}

    ## Devices
    @device_stats = {}
    # Device Classes
    @device_stats["device_classes"] = {}
    Core::DeviceClass.all.each do |dc|
      @device_stats["device_classes"][dc.name] = dc.devices.count
    end

    # update stats tables
    Rails.logger.info("Updating statistics tables")
    Stat::Architecture.delete_all
    @detailed_stats["archs"].each do |arch, count|
      Stat::Architecture.create(name: arch, count: count)
    end
    Stat::OperatingSystem.delete_all
    @detailed_stats["os"].each do |os, count|
      Stat::OperatingSystem.create(name: os, count: count)
    end
    Stat::OsFamily.delete_all
    Stat::OsFamily.create(name: "Ubuntu", count: Stat::OperatingSystem.find_ubuntu.sum(:count))
    Stat::OsFamily.create(name: "Debian", count: Stat::OperatingSystem.find_debian.sum(:count))
    Stat::OsFamily.create(name: "Fedora", count: Stat::OperatingSystem.find_fedora.sum(:count))
    Stat::OsFamily.create(name: "LinuxMint", count: Stat::OperatingSystem.find_linuxmint.sum(:count))
    Stat::OsFamily.create(name: "LinHES", count: Stat::OperatingSystem.find_linhes.sum(:count))
    Stat::OsFamily.create(name: "OpenSUSE", count: Stat::OperatingSystem.find_opensuse.sum(:count))
    Stat::OsFamily.create(name: "Raspbian", count: Stat::OperatingSystem.find_raspbian.sum(:count))
    Stat::OsFamily.create(name: "Other", count: Stat::OperatingSystem.find_other.sum(:count))
    Stat::RunLevel.delete_all
    @detailed_stats["runlevel"].each do |rl, count|
      Stat::RunLevel.create(name: rl, count: count)
    end
    Stat::Language.delete_all
    @detailed_stats["language"].each do |lang, count|
      Stat::Language.create(name: lang, count: count)
    end
    Stat::Vendor.delete_all
    @detailed_stats["vendor"].each do |vendor, count|
      Stat::Vendor.create(name: vendor, count: count)
    end
    Stat::Model.delete_all
    @detailed_stats["model"].each do |model, count|
      Stat::Model.create(name: model, count: count)
    end
    Stat::MemoryBucket.delete_all
    @detailed_stats["ram"].each do |bucket_name, count|
      Stat::MemoryBucket.create(bucket_name: bucket_name, count: count)
    end
    Stat::SwapBucket.delete_all
    @detailed_stats["swap"].each do |bucket_name, count|
      Stat::SwapBucket.create(bucket_name: bucket_name, count: count)
    end
    Stat::CpuVendor.delete_all
    @detailed_stats["cpu"]["vendor"].each do |cpu_vendor, count|
      Stat::CpuVendor.create(name: cpu_vendor, count: count)
    end
    Stat::NumCpu.delete_all
    @detailed_stats["cpu"]["num_cpus"].each do |num_cpus, count|
      Stat::NumCpu.create(num_cpus: num_cpus, count: count)
    end
    Stat::FilesystemType.delete_all
    @detailed_stats["filesystems"]["fs_type"].each do |fs_type, count|
      Stat::FilesystemType.create(name: fs_type, count: count)
    end
    Stat::Kernel.delete_all
    @detailed_stats["kernel"].each do |kernel, count|
      Stat::Kernel.create(name: kernel, count: count)
    end

    ## Devices
    Stat::DeviceClass.delete_all
    @device_stats["device_classes"].each do |name, count|
      Stat::DeviceClass.create(name: name, count: count)
    end
  end
end
