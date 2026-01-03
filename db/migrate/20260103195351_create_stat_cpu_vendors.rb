class CreateStatCpuVendors < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_cpu_vendors do |t|
      t.string :name
      t.bigint :count

      t.timestamps
    end
  end
end
