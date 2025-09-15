class CreateCoreDeviceBuses < ActiveRecord::Migration[8.0]
  def change
    create_table :core_device_buses do |t|
      t.string :name

      t.timestamps
    end
  end
end
