class AddCoreDeviceClassToCoreDevice < ActiveRecord::Migration[8.0]
  def change
    add_reference :core_devices, :core_device_class, null: false, foreign_key: true
  end
end
