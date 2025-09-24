class Processor::DeviceProcessor
  def find_or_create_device!(device)
    begin
      device_bus = Core::DeviceBus.find_or_create_by!(name: device["bus"])
      if device["type"].nil?
        device_class = Core::DeviceClass.find_or_create_by!(name: "NONE")
      else
        device_class = Core::DeviceClass.find_or_create_by!(name: device["type"])
      end
      d = Core::Device.find_or_create_by!(vendor_id: device['vendor_id'],
                                          device_id: device['device_id'],
                                          subsys_vendor_id: device['subsys_vendor_id'],
                                          subsys_device_id: device['subsys_device_id'],
                                          device_bus_id: device_bus.id,
                                          device_class_id: device_class.id)
    rescue ActiveRecord::RecordNotUnique
      retry
    end
    d.update(
      device_driver:  device['driver'],
      description:    device['description'],
    )
    d.save!
    # Return device object
    d
  end
end
