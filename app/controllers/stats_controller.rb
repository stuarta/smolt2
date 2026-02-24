class StatsController < ApplicationController
  include StatsHelper
  def hosts
    # Summary stats
    @host_stats = {}
    @host_stats["total"] = Core::Host.count
    @host_stats["active"] = Core::Host.recent.count
    @host_stats["device_total"] = Core::Device.count
    @host_stats["bogomips"] = Core::Host.sum(:bogomips)
    @host_stats["processors"] = Core::Host.sum(:num_cpus)
    @host_stats["mhz"] = Core::Host.sum(:cpu_speed)

    # Detailed stats
    @detailed_stats = {}

    # Platforms (archs)
    @detailed_stats["archs"] = {}
    Stat::Architecture.all.order(:count).reverse_order.each do |p|
      @detailed_stats["archs"][p.name] = p.count
    end

    # Operating systems
    @detailed_stats["os"] = {}
    Stat::OperatingSystem.all.order(:count).reverse_order.each do |os|
      @detailed_stats["os"][os.name] = os.count
    end
    @detailed_stats["os_groups_total"] = Stat::OperatingSystem.sum(:count)
    @detailed_stats["os_groups"] = {}
    Stat::OsFamily.all.order(:count).reverse_order.each do |os_family|
      @detailed_stats["os_groups"][os_family.name] = {}
      if os_family.name == "Ubuntu"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_ubuntu.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      elsif os_family.name == "Debian"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_debian.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      elsif os_family.name == "Fedora"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_fedora.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      elsif os_family.name == "LinuxMint"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_linuxmint.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      elsif os_family.name == "LinHES"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_linhes.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      elsif os_family.name == "OpenSUSE"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_opensuse.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      elsif os_family.name == "Raspbian"
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_raspbian.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      else (os_family.name == "Other")
        @detailed_stats["os_groups"][os_family.name]["count"] = os_family.count
        @detailed_stats["os_groups"][os_family.name]["os_versions"] = Stat::OperatingSystem.find_other.order(:count).reverse_order.map { |o| { name: o.name, count: o.count } }
      end
    end
    # Runlevel
    @detailed_stats["runlevel"] = {}
    Stat::RunLevel.all.order(:count).reverse_order.each do |rl|
      @detailed_stats["runlevel"][rl.name] = rl.count
    end

    # Language
    @detailed_stats["language"] = {}
    Stat::Language.all.order(:count).reverse_order.each do |language|
      @detailed_stats["language"][language.name] = language.count
    end

    # Vendors
    @detailed_stats["vendor"] = {}
    Stat::Vendor.all.order(:count).reverse_order.limit(50).each do |vendor|
      @detailed_stats["vendor"][vendor.name] = vendor.count
    end

    # Models
    @detailed_stats["model"] = {}
    Stat::Model.all.order(:count).reverse_order.limit(50).each do |model|
      @detailed_stats["model"][model.name] = model.count
    end

    # RAM
    @detailed_stats["ram"] = {}
    Stat::MemoryBucket.all.each do |bucket|
      @detailed_stats["ram"][pretty_memory_bucket_name(bucket.bucket_name)] = bucket.count
    end

    # Swap
    @detailed_stats["swap"] = {}
    Stat::SwapBucket.all.each do |bucket|
      @detailed_stats["swap"][pretty_memory_bucket_name(bucket.bucket_name)] = bucket.count
    end

    # CPU
    @detailed_stats["cpu"] = {}
    @detailed_stats["cpu"]["vendor"] = {}
    Stat::CpuVendor.all.order(:count).each do |cpu|
      @detailed_stats["cpu"]["vendor"][cpu.name] = cpu.count
    end
    @detailed_stats["cpu"]["num_cpus"] = {}
    Stat::NumCpu.all.order(:count).reverse_order.each do |num_cpus|
      @detailed_stats["cpu"]["num_cpus"][num_cpus.num_cpus] = num_cpus.count
    end

    # Kernel
    @detailed_stats["kernel"] = {}
    Stat::Kernel.all.order(:count).reverse_order.limit(50).each do |kernel|
      @detailed_stats["kernel"][kernel.name] = kernel.count
    end

    # Filesystems
    @detailed_stats["filesystems"] = {}
    @detailed_stats["filesystems"]["fs_type"] = {}
    Stat::FilesystemType.all.order(:count).reverse_order.each do |fs_type|
      @detailed_stats["filesystems"]["fs_type"][fs_type.name] = fs_type.count
    end
    @detailed_stats["filesystems"]["size_map"] = {}
    Stat::FilesystemSize.all.each do |fs_size|
      @detailed_stats["filesystems"]["size_map"][pretty_fs_bucket_name(fs_size.bucket_name)] = fs_size.count
    end
  end

  def devices
    @device_stats = {}
    @device_stats["unique"] = Core::Device.count
    @device_stats["device_classes"] = {}
    Stat::DeviceClass.all.order(:count).reverse_order.limit(25).each do |dc|
      @device_stats["device_classes"][dc.name] = { id: Core::DeviceClass.find_by(name: dc.name).id, count: dc.count }
    end
  end

  def mythtv
    @mythtv_stats = {}
    @mythtv_stats["total"] = Myth::Host.recent.count
    @mythtv_stats["active"] = Myth::Host.recent.pluck(:uuid_id).uniq.count
    @mythtv_stats["tuners_total"] = Myth::Tuner.sum(:tuner_count)
    @mythtv_stats["clusters"] = {}
    Myth::Host.recent.group(:uuid_id).count.to_h.each do |k, v|
      if @mythtv_stats["clusters"][v]
        @mythtv_stats["clusters"][v] += 1
      else
        @mythtv_stats["clusters"][v] = 1
      end
    end
    @mythtv_stats["tuner_info"] = {}
    @mythtv_stats["tuner_info"]["min"] = Myth::Tuner.recent.minimum(:tuner_count)
    @mythtv_stats["tuner_info"]["max"] = Myth::Tuner.recent.maximum(:tuner_count)
    @mythtv_stats["tuner_info"]["average"] = Myth::Tuner.recent.average(:tuner_count).to_f.round(2)
    @mythtv_stats["tuner_info"]["stddev"] = Myth::Tuner.recent.select("STDDEV_SAMP(tuner_count) as stddev").take.stddev.round(2)
    @mythtv_stats["vtuner_info"] = {}
    @mythtv_stats["vtuner_info"]["min"] = Myth::Host.recent.minimum(:vtpertuner)
    @mythtv_stats["vtuner_info"]["max"] = Myth::Host.recent.maximum(:vtpertuner)
    @mythtv_stats["vtuner_info"]["average"] = Myth::Host.recent.average(:vtpertuner).to_f.round(2)
    @mythtv_stats["vtuner_info"]["stddev"] = Myth::Host.recent.select("STDDEV_SAMP(vtpertuner) as stddev").take.stddev.round(2)
    @mythtv_stats["tuner_breakdown"] = Myth::Tuner.recent.group(:name).count.sort_by { |k, v| -v }.to_h

    # MythTV Version Stats
    @mythtv_stats["version"] = {}
    Stat::MythVersion.all.order(:count).reverse_order.each do |version|
      @mythtv_stats["version"][version.bucket_name] = version.count
    end
    @mythtv_stats["db_version"] = {}
    Stat::MythDbVersion.all.order(:count).reverse_order.each do |db_version|
      @mythtv_stats["db_version"][db_version.name] = db_version.count
    end

    # MythTV General Stats
    @mythtv_stats["language"] = {}
    Stat::MythLanguage.all.order(:count).reverse_order.each do |language|
      @mythtv_stats["language"][language.name] = language.count
    end
    @mythtv_stats["timezone"] = {}
    Stat::MythTimezone.all.order(:count).reverse_order.limit(50).each do |timezone|
      @mythtv_stats["timezone"][timezone.name] = timezone.count
    end
    @mythtv_stats["country"] = {}
    Stat::MythCountry.all.order(:count).reverse_order.limit(50).each do |country|
      @mythtv_stats["country"][country.name] = country.count
    end
    @mythtv_stats["theme"] = {}
    Stat::MythTheme.all.order(:count).reverse_order.limit(50).each do |theme|
      @mythtv_stats["theme"][theme.name] = theme.count
    end
    @mythtv_stats["remote"] = {}
    Stat::MythRemote.all.order(:count).reverse_order.each do |remote|
      @mythtv_stats["remote"][remote.name] = remote.count
    end
  end
end
