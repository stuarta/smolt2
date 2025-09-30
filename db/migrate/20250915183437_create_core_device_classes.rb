class CreateCoreDeviceClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :core_device_classes do |t|
      t.string :name, null: false

      t.timestamps
      t.index [:name], name: "dev_classes_idx", unique: true
    end
  end
end
