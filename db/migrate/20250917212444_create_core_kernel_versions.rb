class CreateCoreKernelVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :core_kernel_versions do |t|
      t.string :kernel_version

      t.timestamps
    end
  end
end
