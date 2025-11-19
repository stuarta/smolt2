class CreateMythVersionBuckets < ActiveRecord::Migration[8.0]
  def change
    create_table :myth_version_buckets do |t|
      t.string :version_bucket

      t.timestamps
    end
  end
end
