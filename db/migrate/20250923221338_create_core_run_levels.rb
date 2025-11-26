class CreateCoreRunLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :core_run_levels do |t|
      t.string :default_runlevel

      t.timestamps
      t.index [ :default_runlevel ], name: "default_runlevel_idx", unique: true
    end
  end
end
