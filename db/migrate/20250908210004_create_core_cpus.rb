class CreateCoreCpus < ActiveRecord::Migration[8.0]
  def change
    create_table :core_cpus do |t|
      t.integer :cpu_family
      t.integer :cpu_stepping
      t.integer :cpu_model_num
      t.text :cpu_vendor
      t.text :cpu_model

      t.timestamps
    end
    add_index :core_cpus, [:cpu_family, :cpu_stepping, :cpu_model_num]
  end
end
