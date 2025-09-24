class CreateCoreHosts < ActiveRecord::Migration[8.0]
  def change
    create_table :core_hosts do |t|
      t.string :system
      t.integer :bogomips
      t.integer :system_memory
      t.integer :system_swap
      t.integer :num_cpus
      t.integer :cpu_speed
      t.integer :selinux_enabled
      t.string :selinux_policy
      t.string :selinux_enforce

      t.timestamps
    end
  end
end
