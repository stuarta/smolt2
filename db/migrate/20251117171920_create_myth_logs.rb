class CreateMythLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_logs do |t|
      t.string :level
      t.float :value

      t.timestamps
    end
  end
end
