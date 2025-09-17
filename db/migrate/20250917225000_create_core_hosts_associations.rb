class CreateCoreHostsAssociations < ActiveRecord::Migration[8.0]
  def change
    add_reference :core_hosts, :core_host_pub_mapping, null: false, foreign_key: true
    add_reference :core_hosts, :core_platform, null: false, foreign_key: true
    add_reference :core_hosts, :core_operating_system, null: false, foreign_key: true
    add_reference :core_hosts, :core_vendor, null: false, foreign_key: true
    add_reference :core_hosts, :core_cpu, null: false, foreign_key: true
    add_reference :core_hosts, :core_kernel_version, null: false, foreign_key: true
    add_reference :core_hosts, :core_formfactor, null: false, foreign_key: true

    add_reference :core_filesystems, :core_host, null: false, foreign_key: true
  end
end
