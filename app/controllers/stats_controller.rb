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
  end

  def devices
  end
end
