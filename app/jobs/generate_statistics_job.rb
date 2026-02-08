class GenerateStatisticsJob < ApplicationJob
  queue_as :solid_queue_recurring

  def perform(*args)
    hosts_recent = Core::Host.recent # Hosts seen recently
    @detailed_stats = {}

    # Platforms (archs)
    @detailed_stats["archs"] = {}
    hosts_recent.group(:platform_id).count.to_h.each do |platform_id, count|
      @detailed_stats["archs"][Core::Platform.find(platform_id).platform] = count
    end

    # Operating systems
    @detailed_stats["os"] = {}
    hosts_recent.group(:operating_system_id).count.to_h.each do |os_id, count|
      @detailed_stats["os"][Core::OperatingSystem.find(os_id).os] = count
    end

    # Runlevel
    @detailed_stats["runlevel"] = {}
    hosts_recent.group(:run_level_id).count.to_h.each do |runlevel_id, count|
      @detailed_stats["runlevel"][Core::RunLevel.find(runlevel_id).default_runlevel] = count
    end

    # Language
    @detailed_stats["language"] = {}
    hosts_recent.group(:language_id).count.to_h.each do |language_id, count|
      @detailed_stats["language"][Core::Language.find(language_id).language] = count
    end

    # Vendors
    @detailed_stats["vendor"] = {}
    hosts_recent.group(:vendor_id).count.to_h.each do |vendor_id, count|
      @detailed_stats["vendor"][Core::Vendor.find(vendor_id).name] = count
    end

    # Models
    @detailed_stats["model"] = {}
    hosts_recent.group(:system).count.to_h.each do |model, count|
      @detailed_stats["model"][model] = count
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
    hosts_recent.group(:cpu_id).count.to_h.each do |cpu_id, count|
      @detailed_stats["cpu"]["vendor"][Core::Cpu.find(cpu_id).cpu_vendor] = count
    end
    @detailed_stats["cpu"]["num_cpus"] = {}
    hosts_recent.group(:num_cpus).count.to_h.each do |num_cpus, count|
      @detailed_stats["cpu"]["num_cpus"][num_cpus] = count
    end

    # Kernel
    @detailed_stats["kernel"] = {}
    hosts_recent.group(:kernel_version_id).count.to_h.each do |kernel_id, count|
      @detailed_stats["kernel"][Core::KernelVersion.find(kernel_id).kernel_version] = count
    end

    # Filesystems
    @detailed_stats["filesystems"] = {}
    @detailed_stats["filesystems"]["fs_type"] = {}
    Core::Filesystem.recent.group(:fs_type).count.to_h.each do |fs_type, count|
      @detailed_stats["filesystems"]["fs_type"][fs_type] = count
    end
    @detailed_stats["filesystems"]["size_map"] = {}
    @detailed_stats["filesystems"]["size_map"]["0_to_2Gb"] = Core::Filesystem.recent.filesystem_0_to_2Gb.count
    @detailed_stats["filesystems"]["size_map"]["2Gb_to_100Gb"] = Core::Filesystem.recent.filesystem_2Gb_to_100Gb.count
    @detailed_stats["filesystems"]["size_map"]["100Gb_to_200Gb"] = Core::Filesystem.recent.filesystem_100Gb_to_200Gb.count
    @detailed_stats["filesystems"]["size_map"]["200Gb_to_400Gb"] = Core::Filesystem.recent.filesystem_200Gb_to_400Gb.count
    @detailed_stats["filesystems"]["size_map"]["400Gb_to_700Gb"] = Core::Filesystem.recent.filesystem_400Gb_to_700Gb.count
    @detailed_stats["filesystems"]["size_map"]["700Gb_to_1Tb"] = Core::Filesystem.recent.filesystem_700Gb_to_1Tb.count
    @detailed_stats["filesystems"]["size_map"]["1Tb_to_2Tb"] = Core::Filesystem.recent.filesystem_1Tb_to_2Tb.count
    @detailed_stats["filesystems"]["size_map"]["2Tb_to_4Tb"] = Core::Filesystem.recent.filesystem_2Tb_to_4Tb.count
    @detailed_stats["filesystems"]["size_map"]["4Tb_to_8Tb"] = Core::Filesystem.recent.filesystem_4Tb_to_8Tb.count
    @detailed_stats["filesystems"]["size_map"]["8Tb_plus"] = Core::Filesystem.recent.filesystem_8Tb_plus.count
    ## Devices
    @device_stats = {}
    # Device Classes
    @device_stats["device_classes"] = {}
    Core::Device.group(:device_class_id).count.to_h.each do |device_class_id, count|
      @device_stats["device_classes"][Core::DeviceClass.find(device_class_id).name] = count
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
    Stat::FilesystemSize.delete_all
    @detailed_stats["filesystems"]["size_map"].each do |bucket_name, count|
      Stat::FilesystemSize.create(bucket_name: bucket_name, count: count)
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
