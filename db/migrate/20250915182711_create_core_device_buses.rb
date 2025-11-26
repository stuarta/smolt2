class CreateCoreDeviceBuses < ActiveRecord::Migration[8.0]
  def change
    create_table :core_device_buses do |t|
      t.string :name, null: false

      t.timestamps
      t.index [ :name ], name: "dev_buses_idx", unique: true
    end
  end
end
