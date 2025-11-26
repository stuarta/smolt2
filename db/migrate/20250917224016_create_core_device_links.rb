class CreateCoreDeviceLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :core_device_links do |t|
      t.references :device, null: false, foreign_key: { to_table: :core_devices }
      t.references :host, null: false, foreign_key: { to_table: :core_hosts }

      t.timestamps
    end
  end
end
