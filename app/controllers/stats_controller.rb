class StatsController < ApplicationController
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
    Stat::Vendor.all.order(:count).reverse_order.each do |vendor|
      @detailed_stats["vendor"][vendor.name] = vendor.count
    end

    # Models
    @detailed_stats["model"] = {}
    Stat::Model.all.order(:count).reverse_order.each do |model|
      @detailed_stats["model"][model.name] = model.count
    end

    # RAM
    @detailed_stats["ram"] = {}
    # Need to map to size buckets

    # Swap
    @detailed_stats["swap"] = {}
    # Need to map to size buckets

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
    Stat::Kernel.all.order(:count).reverse_order.each do |kernel|
      @detailed_stats["kernel"][kernel.name] = kernel.count
    end

    # Filesystems
    @detailed_stats["filesystems"] = {}
    @detailed_stats["filesystems"]["fs_type"] = {}
    Stat::FilesystemType.all.order(:count).reverse_order.each do |fs_type|
      @detailed_stats["filesystems"]["fs_type"][fs_type.name] = fs_type.count
    end
    @detailed_stats["filesystems"]["size_map"] = {}
  end

  def devices
  end
end
