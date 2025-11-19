# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_11_19_074200) do
  create_table "batch_queue", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.timestamp "arrival", default: -> { "current_timestamp()" }
    t.integer "added", null: false
    t.string "hw_uuid", null: false
    t.text "data"
  end

  create_table "core_cpus", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "cpu_family"
    t.integer "cpu_stepping"
    t.integer "cpu_model_num"
    t.text "cpu_vendor"
    t.text "cpu_model"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpu_family", "cpu_stepping", "cpu_model_num"], name: "idx_on_cpu_family_cpu_stepping_cpu_model_num_bac05741b8"
  end

  create_table "core_device_buses", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "dev_buses_idx", unique: true
  end

  create_table "core_device_classes", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "dev_classes_idx", unique: true
  end

  create_table "core_device_links", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_core_device_links_on_device_id"
    t.index ["host_id"], name: "index_core_device_links_on_host_id"
  end

  create_table "core_devices", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "vendor_id", null: false
    t.integer "device_id", null: false
    t.integer "subsys_vendor_id"
    t.integer "subsys_device_id"
    t.string "description", default: ""
    t.string "device_driver", default: "Unknown"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "device_bus_id", null: false
    t.bigint "device_class_id", null: false
    t.index ["device_bus_id"], name: "index_core_devices_on_device_bus_id"
    t.index ["device_class_id"], name: "index_core_devices_on_device_class_id"
    t.index ["vendor_id", "device_id", "subsys_vendor_id", "subsys_device_id"], name: "idx_devices", unique: true
  end

  create_table "core_filesystems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "mnt_pnt"
    t.string "fs_type"
    t.bigint "f_favail"
    t.bigint "f_bsize"
    t.bigint "f_frsize"
    t.bigint "f_blocks"
    t.bigint "f_bfree"
    t.bigint "f_bavail"
    t.bigint "f_files"
    t.bigint "f_ffree"
    t.bigint "f_fssize"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "host_id", null: false
    t.index ["host_id"], name: "index_core_filesystems_on_host_id"
  end

  create_table "core_formfactors", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "formfactor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formfactor"], name: "formfactor_idx", unique: true
  end

  create_table "core_host_pub_mappings", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "pub_uuid", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["uuid", "pub_uuid"], name: "idx_host_pub", unique: true
  end

  create_table "core_hosts", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "system"
    t.integer "bogomips"
    t.integer "system_memory"
    t.integer "system_swap"
    t.integer "num_cpus"
    t.integer "cpu_speed"
    t.integer "selinux_enabled"
    t.string "selinux_policy"
    t.string "selinux_enforce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "host_pub_mapping_id", null: false
    t.bigint "platform_id", null: false
    t.bigint "operating_system_id", null: false
    t.bigint "vendor_id", null: false
    t.bigint "cpu_id", null: false
    t.bigint "kernel_version_id", null: false
    t.bigint "formfactor_id", null: false
    t.bigint "language_id", null: false
    t.bigint "run_level_id", null: false
    t.index ["cpu_id"], name: "index_core_hosts_on_cpu_id"
    t.index ["formfactor_id"], name: "index_core_hosts_on_formfactor_id"
    t.index ["host_pub_mapping_id"], name: "index_core_hosts_on_host_pub_mapping_id"
    t.index ["kernel_version_id"], name: "index_core_hosts_on_kernel_version_id"
    t.index ["language_id"], name: "index_core_hosts_on_language_id"
    t.index ["operating_system_id"], name: "index_core_hosts_on_operating_system_id"
    t.index ["platform_id"], name: "index_core_hosts_on_platform_id"
    t.index ["run_level_id"], name: "index_core_hosts_on_run_level_id"
    t.index ["vendor_id"], name: "index_core_hosts_on_vendor_id"
  end

  create_table "core_kernel_versions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "kernel_version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kernel_version"], name: "k_ver_idx", unique: true
  end

  create_table "core_languages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language"], name: "language_idx", unique: true
  end

  create_table "core_operating_systems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "os"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["os"], name: "os_idx", unique: true
  end

  create_table "core_platforms", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["platform"], name: "platform_idx", unique: true
  end

  create_table "core_run_levels", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "default_runlevel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["default_runlevel"], name: "default_runlevel_idx", unique: true
  end

  create_table "core_submissions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "arrival", precision: nil, default: -> { "current_timestamp()" }
    t.boolean "added", default: false
    t.string "hw_uuid", null: false
    t.text "data", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "core_vendors", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "vendors_idx", unique: true
  end

  create_table "file_systems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "host_id"
    t.text "mnt_pnt"
    t.text "fs_type"
    t.integer "f_favail"
    t.integer "f_bsize"
    t.integer "f_frsize"
    t.integer "f_blocks"
    t.integer "f_bfree"
    t.integer "f_bavail"
    t.integer "f_files"
    t.integer "f_ffree"
    t.integer "f_fssize"
  end

  create_table "host", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.text "uuid", null: false
    t.text "pub_uuid", null: false
    t.text "os"
    t.text "platform"
    t.decimal "bogomips", precision: 10
    t.integer "system_memory"
    t.integer "system_swap"
    t.text "vendor"
    t.text "system"
    t.text "cpu_vendor"
    t.text "cpu_model"
    t.integer "num_cpus"
    t.decimal "cpu_speed", precision: 10
    t.text "language"
    t.integer "default_runlevel"
    t.text "kernel_version"
    t.text "formfactor"
    t.timestamp "last_modified", null: false
    t.integer "rating", null: false
    t.integer "selinux_enabled", null: false
    t.text "selinux_policy"
    t.text "selinux_enforce"
    t.integer "cpu_stepping"
    t.integer "cpu_family"
    t.integer "cpu_model_num"
    t.index ["id", "last_modified"], name: "last_modified_join"
    t.index ["last_modified"], name: "index_host_on_last_modified"
    t.index ["platform"], name: "index_host_on_platform", length: 1024
    t.index ["pub_uuid"], name: "index_host_on_pub_uuid", unique: true, using: :hash
    t.index ["uuid"], name: "index_host_on_uuid", unique: true, using: :hash
  end

  create_table "myth_audios", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "passthru"
    t.integer "stereopcm"
    t.string "upmixtype"
    t.integer "volcontrol"
    t.integer "defaultupmix"
    t.integer "passthruoverride"
    t.string "mixercontrol"
    t.integer "sr_override"
    t.string "passthrudevice"
    t.string "device"
    t.string "mixerdevice"
    t.string "audio_sys"
    t.string "audio_sys_version"
    t.integer "jack"
    t.integer "pulse"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_branches", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "branch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_databases", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "used_engine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "db_version_id", null: false
    t.index ["db_version_id"], name: "index_myth_databases_on_db_version_id"
  end

  create_table "myth_databases_db_engines", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "database_id"
    t.bigint "db_engine_id"
    t.index ["database_id"], name: "index_myth_databases_db_engines_on_database_id"
    t.index ["db_engine_id"], name: "index_myth_databases_db_engines_on_db_engine_id"
  end

  create_table "myth_databases_schemaversions", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "database_id"
    t.bigint "schemaversion_id"
    t.index ["database_id"], name: "index_myth_databases_schemaversions_on_database_id"
    t.index ["schemaversion_id"], name: "index_myth_databases_schemaversions_on_schemaversion_id"
  end

  create_table "myth_db_engines", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "engine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_db_versions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_grabbers", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "grabber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_historicals", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "db_age"
    t.bigint "rectime"
    t.bigint "reccount"
    t.bigint "showcount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_languages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "language"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_logs", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "level"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_playback_profile_details", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "decoder"
    t.string "deint_pri"
    t.string "deint_sec"
    t.string "renderer"
    t.string "filters"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_playback_profile_details_profiles", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "playback_profile_id"
    t.bigint "playback_profile_detail_id"
    t.index ["playback_profile_detail_id"], name: "idx_on_playback_profile_detail_id_e169a2ac8f"
    t.index ["playback_profile_id"], name: "idx_on_playback_profile_id_f781fcb6be"
  end

  create_table "myth_playback_profiles", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "profile_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_recordings", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "count"
    t.bigint "size"
    t.bigint "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_schemaversions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.integer "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_storages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.bigint "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_tuners", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name"
    t.integer "tuner_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_uuids", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "myth_uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "core_device_links", "core_devices", column: "device_id"
  add_foreign_key "core_device_links", "core_hosts", column: "host_id"
  add_foreign_key "core_devices", "core_device_buses", column: "device_bus_id"
  add_foreign_key "core_devices", "core_device_classes", column: "device_class_id"
  add_foreign_key "core_filesystems", "core_hosts", column: "host_id"
  add_foreign_key "core_hosts", "core_cpus", column: "cpu_id"
  add_foreign_key "core_hosts", "core_formfactors", column: "formfactor_id"
  add_foreign_key "core_hosts", "core_host_pub_mappings", column: "host_pub_mapping_id"
  add_foreign_key "core_hosts", "core_kernel_versions", column: "kernel_version_id"
  add_foreign_key "core_hosts", "core_languages", column: "language_id"
  add_foreign_key "core_hosts", "core_operating_systems", column: "operating_system_id"
  add_foreign_key "core_hosts", "core_platforms", column: "platform_id"
  add_foreign_key "core_hosts", "core_run_levels", column: "run_level_id"
  add_foreign_key "core_hosts", "core_vendors", column: "vendor_id"
  add_foreign_key "file_systems", "host", column: "id"
  add_foreign_key "myth_databases", "myth_db_versions", column: "db_version_id"
end
