class FixDevicesIndex < ActiveRecord::Migration[8.1]
  def change
    remove_index :core_devices, name: :idx_devices
    add_index :core_devices,
      [ :vendor_id, :device_id, :subsys_vendor_id, :subsys_device_id, :device_bus_id, :device_class_id ],
      unique: true,
      name: "idx_devices"
  end
end
