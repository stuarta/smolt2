class CreateStatDeviceClasses < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_device_classes do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
