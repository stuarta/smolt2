class AddCoreDeviceBusToCoreDevice < ActiveRecord::Migration[8.0]
  def change
    add_reference :core_devices, :device_bus, null: false, foreign_key: {to_table: :core_device_buses}
  end
end
