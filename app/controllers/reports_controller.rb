class ReportsController < ApplicationController
  def recent
    @hosts = Core::Host.last(20)
    @devices = Core::Device.last(20)
  end

  def search_profiles
  end

  def view_profile
  end

  def view_profiles
  end

  def search_devices
  end

  def view_device
  end

  def view_devices
  end

  def search
  end
end
