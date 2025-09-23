class CreateCoreRunLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :core_run_levels do |t|
      t.string :default_runlevel

      t.timestamps
    end
  end
end
