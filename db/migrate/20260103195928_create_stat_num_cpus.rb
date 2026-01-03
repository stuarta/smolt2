class CreateStatNumCpus < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_num_cpus do |t|
      t.integer :num_cpus
      t.bigint :count

      t.timestamps
    end
  end
end
