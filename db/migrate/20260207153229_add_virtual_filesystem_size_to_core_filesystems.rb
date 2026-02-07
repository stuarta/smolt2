class AddVirtualFilesystemSizeToCoreFilesystems < ActiveRecord::Migration[8.1]
  def up
    add_column :core_filesystems, :fs_size_mb, :virtual, type: :bigint, as: "f_blocks * f_bsize / 1024 / 1024", stored: false
  end
  def down
    remove_column :core_filesystems, :fs_size_mb
  end
end
