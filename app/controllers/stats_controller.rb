class StatsController < ApplicationController
  def hosts
    @host_stats = {}
    @host_stats["total"] = Core::Host.count
    date_now = Date.today
    date_minus_90d = date_now - 90
    @host_stats["active"] = Core::Host.where("updated_at > ?", date_minus_90d).count
    @host_stats["device_total"] = Core::Device.count
    @host_stats["bogomips"] = Core::Host.sum(:bogomips)
    @host_stats["processors"] = Core::Host.sum(:num_cpus)
    @host_stats["mhz"] = Core::Host.sum(:cpu_speed)
  end

  def devices
  end
end
