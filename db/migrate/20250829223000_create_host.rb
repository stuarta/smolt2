class CreateHost < ActiveRecord::Migration[7.2]
  def change
    create_table :host, if_not_exists: true do |t|
      t.text :uuid,                 null: false
      t.text :pub_uuid,             null: false
      t.text :os,                   default: -> { 'NULL' }
      t.text :platform,             default: -> { 'NULL' }
      t.decimal :bogomips,          default: -> { 'NULL' }
      t.integer :system_memory,     default: -> { 'NULL' }
      t.integer :system_swap,       default: -> { 'NULL' }
      t.text :vendor,               default: -> { 'NULL' }
      t.text :system,               default: -> { 'NULL' }
      t.text :cpu_vendor,           default: -> { 'NULL' }
      t.text :cpu_model,            default: -> { 'NULL' }
      t.integer :num_cpus,          default: -> { 'NULL' }
      t.decimal :cpu_speed,         default: -> { 'NULL' }
      t.text :language,             default: -> { 'NULL' }
      t.integer :default_runlevel,  default: -> { 'NULL' }
      t.text :kernel_version,       default: -> { 'NULL' }
      t.text :formfactor,           default: -> { 'NULL' }
      t.timestamp :last_modified,   null: false
      t.integer :rating,            null: false
      t.integer :selinux_enabled,   null: false
      t.text :selinux_policy,       default: -> { 'NULL' }
      t.text :selinux_enforce,      default: -> { 'NULL' }
      t.integer :cpu_stepping,      default: -> { 'NULL' }
      t.integer :cpu_family,        default: -> { 'NULL' }
      t.integer :cpu_model_num,     default: -> { 'NULL' }
    end
    add_index :host, [ :uuid ], unique: true
    add_index :host, [ :pub_uuid ], unique: true
    add_index :host, [ :platform ]
    add_index :host, [ :id, :last_modified ], name: "last_modified_join"
    add_index :host, [ :last_modified ]
  end
end
