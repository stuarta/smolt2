class CreateCoreDeviceLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :core_device_links do |t|
      t.references :core_device, null: false, foreign_key: true
      t.references :core_host, null: false, foreign_key: true

      t.timestamps
    end
  end
end
