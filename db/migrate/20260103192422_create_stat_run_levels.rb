class CreateStatRunLevels < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_run_levels do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
