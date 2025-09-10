class CreateCoreOperatingSystems < ActiveRecord::Migration[8.0]
  def change
    create_table :core_operating_systems do |t|
      t.text :os

      t.timestamps
    end
  end
end
