class CreateStatMemoryBuckets < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_memory_buckets do |t|
      t.string :bucket_name
      t.bigint :count

      t.timestamps
    end
  end
end
