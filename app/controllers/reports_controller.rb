class ReportsController < ApplicationController
  def recent
    @hosts = Core::Host.last(20)
    @devices = Core::Device.last(20)
  end

  def search_profiles
  end

  def view_profile
    @host = if not params[:id].nil?
      Core::Host.find(params[:id])
    elsif not params[:uuid].nil?
      if params[:uuid].start_with?("pub_")
        hpm = Core::HostPubMapping.where(pub_uuid: params[:uuid]).last
        if not hpm.nil?
          Core::Host.where(host_pub_mapping_id: hpm.id)
        end
      else
        hpm = Core::HostPubMapping.where(uuid: params[:uuid]).last
        if not hpm.nil?
          Core::Host.where(host_pub_mapping_id: hpm.id)
        end
      end
    else
      nil
    end
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
