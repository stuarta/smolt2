class CreateCoreDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :core_devices do |t|
      t.integer     :vendor_id,         null: false
      t.integer     :device_id,         null: false
      t.integer     :subsys_vendor_id,  default: -> {'NULL'}
      t.integer     :subsys_device_id,  default: -> {'NULL'}
      t.string      :device_bus,        default: 'Unknown'
      t.string      :device_type,       default: 'Unknown'
      t.string      :description,       default: ''
      t.string      :device_driver,     default: 'Unknown'

      t.timestamps
    end
    add_index :core_devices,
      [:vendor_id, :device_id, :subsys_vendor_id, :subsys_device_id],
      unique: true,
      name: "idx_devices"
  end
end
