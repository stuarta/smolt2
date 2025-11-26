class AddCoreDeviceClassToCoreDevice < ActiveRecord::Migration[8.0]
  def change
    add_reference :core_devices, :device_class, null: false, foreign_key: { to_table: :core_device_classes }
  end
end
