class CreateStatFilesystemSizes < ActiveRecord::Migration[8.1]
  def change
    create_table :stat_filesystem_sizes do |t|
      t.string :bucket_name
      t.bigint :count

      t.timestamps
    end
  end
end
