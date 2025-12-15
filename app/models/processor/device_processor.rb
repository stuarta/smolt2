class Processor::DeviceProcessor
  def find_or_create_device!(device)
    return nil if device["vendor_id"].nil? or device["device_id"].nil?
    if device["subsys_vendor_id"].nil?
      device["subsys_vendor_id"] = -1
    end
    if device["subsys_device_id"].nil?
      device["subsys_device_id"] = -1
    end
    begin
      device_bus = Core::DeviceBus.create!(name: device["bus"])
    rescue ActiveRecord::RecordNotUnique
      device_bus = Core::DeviceBus.find_by(name: device["bus"])
    end
    if device["type"].nil?
      begin
        device_class = Core::DeviceClass.create!(name: "NONE")
      rescue ActiveRecord::RecordNotUnique
        device_class = Core::DeviceClass.find_by(name: "NONE")
      end
    else
      begin
        device_class = Core::DeviceClass.create!(name: device["type"])
      rescue ActiveRecord::RecordNotUnique
        device_class = Core::DeviceClass.find_by(name: device["type"])
      end
    end
    begin
      d = Core::Device.create!(vendor_id: device["vendor_id"],
                                device_id: device["device_id"],
                                subsys_vendor_id: device["subsys_vendor_id"],
                                subsys_device_id: device["subsys_device_id"],
                                device_bus_id: device_bus.id,
                                device_class_id: device_class.id
                              )
    rescue ActiveRecord::RecordNotUnique
      d = Core::Device.find_by(vendor_id: device["vendor_id"],
                                device_id: device["device_id"],
                                subsys_vendor_id: device["subsys_vendor_id"],
                                subsys_device_id: device["subsys_device_id"],
                                device_bus_id: device_bus.id,
                                device_class_id: device_class.id
                              )
    end
    begin
      d.update(
        device_driver:  device["driver"],
        description:    device["description"],
      )
    rescue ActiveRecord::Deadlocked
      sleep 0.2
      retry
    end
    d.save!
    # Return device object
    d
  end
end
