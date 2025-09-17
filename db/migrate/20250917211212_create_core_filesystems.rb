class CreateCoreFilesystems < ActiveRecord::Migration[8.0]
  def change
    create_table :core_filesystems do |t|
      t.string :mnt_pnt
      t.string :fs_type
      t.bigint :f_favail
      t.bigint :f_bsize
      t.bigint :f_frsize
      t.bigint :f_blocks
      t.bigint :f_bfree
      t.bigint :f_bavail
      t.bigint :f_files
      t.bigint :f_ffree
      t.bigint :f_fssize

      t.timestamps
    end
  end
end
