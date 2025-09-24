class CreateCoreHostsAssociations < ActiveRecord::Migration[8.0]
  def change
    add_reference :core_hosts, :host_pub_mapping, null: false, foreign_key: {to_table: :core_host_pub_mappings}
    add_reference :core_hosts, :platform, null: false, foreign_key: {to_table: :core_platforms}
    add_reference :core_hosts, :operating_system, null: false, foreign_key: {to_table: :core_operating_systems}
    add_reference :core_hosts, :vendor, null: false, foreign_key: {to_table: :core_vendors}
    add_reference :core_hosts, :cpu, null: false, foreign_key: {to_table: :core_cpus}
    add_reference :core_hosts, :kernel_version, null: false, foreign_key: {to_table: :core_kernel_versions}
    add_reference :core_hosts, :formfactor, null: false, foreign_key: {to_table: :core_formfactors}
    add_reference :core_hosts, :language, null: false, foreign_key: {to_table: :core_languages}
    add_reference :core_hosts, :run_level, null: false, foreign_key: {to_table: :core_run_levels}

    add_reference :core_filesystems, :host, null: false, foreign_key: {to_table: :core_hosts}
  end
end
