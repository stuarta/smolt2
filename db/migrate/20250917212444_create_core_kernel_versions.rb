class CreateCoreKernelVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :core_kernel_versions do |t|
      t.string :kernel_version

      t.timestamps
      t.index [ :kernel_version ], name: "k_ver_idx", unique: true
    end
  end
end
