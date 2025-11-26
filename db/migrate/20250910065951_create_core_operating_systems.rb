class CreateCoreOperatingSystems < ActiveRecord::Migration[8.0]
  def change
    create_table :core_operating_systems do |t|
      t.string :os

      t.timestamps
      t.index [ :os ], name: "os_idx", unique: true
    end
  end
end
