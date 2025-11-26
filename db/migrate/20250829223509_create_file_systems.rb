class CreateFileSystems < ActiveRecord::Migration[7.2]
  def change
    create_table :file_systems, if_not_exists: true do |t|
      t.integer :host_id,   default: -> { 'NULL' }
      t.text    :mnt_pnt,   default: -> { 'NULL' }
      t.text    :fs_type,   default: -> { 'NULL' }
      t.integer :f_favail,  default: -> { 'NULL' }
      t.integer :f_bsize,   default: -> { 'NULL' }
      t.integer :f_frsize,  default: -> { 'NULL' }
      t.integer :f_blocks,  default: -> { 'NULL' }
      t.integer :f_bfree,   default: -> { 'NULL' }
      t.integer :f_bavail,  default: -> { 'NULL' }
      t.integer :f_files,   default: -> { 'NULL' }
      t.integer :f_ffree,   default: -> { 'NULL' }
      t.integer :f_fssize,  default: -> { 'NULL' }

      t.foreign_key :host, column: :id
    end
  end
end
