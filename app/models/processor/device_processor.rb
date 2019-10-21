class Processor::DeviceProcessor
  def find_or_create_device!(device)
    begin
      d = Core::Device.find_or_create_by!(vendor_id: device['vendor_id'], device_id: device['device_id'], subsys_vendor_id: device['subsys_vendor_id'], subsys_device_id: device['subsys_device_id'])
    rescue ActiveRecord::RecordNotUnique => e
      retry
    end
    d.update(
      device_bus:     device['bus'],
      device_type:    device['type'],
      device_driver:  device['driver'],
      description:    device['description'],
    )
    d.save!
    # Return device object
    d
  end
end
