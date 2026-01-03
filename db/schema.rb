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

ActiveRecord::Schema[8.1].define(version: 2026_01_03_205332) do
  create_table "batch_queue", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "added", null: false
    t.timestamp "arrival", default: -> { "current_timestamp()" }
    t.text "data"
    t.string "hw_uuid", null: false
  end

  create_table "core_cpus", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "cpu_family"
    t.text "cpu_model"
    t.integer "cpu_model_num"
    t.integer "cpu_stepping"
    t.text "cpu_vendor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpu_family", "cpu_stepping", "cpu_model_num"], name: "idx_on_cpu_family_cpu_stepping_cpu_model_num_bac05741b8"
  end

  create_table "core_device_buses", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "dev_buses_idx", unique: true
  end

  create_table "core_device_classes", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "dev_classes_idx", unique: true
  end

  create_table "core_device_links", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "device_id", null: false
    t.bigint "host_id", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_core_device_links_on_device_id"
    t.index ["host_id"], name: "index_core_device_links_on_host_id"
  end

  create_table "core_devices", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "description", default: ""
    t.bigint "device_bus_id", null: false
    t.bigint "device_class_id", null: false
    t.string "device_driver", default: "Unknown"
    t.integer "device_id", null: false
    t.integer "subsys_device_id"
    t.integer "subsys_vendor_id"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "vendor_id", null: false
    t.index ["device_bus_id"], name: "index_core_devices_on_device_bus_id"
    t.index ["device_class_id"], name: "index_core_devices_on_device_class_id"
    t.index ["vendor_id", "device_id", "subsys_vendor_id", "subsys_device_id", "device_bus_id", "device_class_id"], name: "idx_devices", unique: true
  end

  create_table "core_filesystems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "f_bavail"
    t.bigint "f_bfree"
    t.bigint "f_blocks"
    t.bigint "f_bsize"
    t.bigint "f_favail"
    t.bigint "f_ffree"
    t.bigint "f_files"
    t.bigint "f_frsize"
    t.bigint "f_fssize"
    t.string "fs_type"
    t.bigint "host_id", null: false
    t.string "mnt_pnt"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_core_filesystems_on_host_id"
  end

  create_table "core_formfactors", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "formfactor"
    t.datetime "updated_at", null: false
    t.index ["formfactor"], name: "formfactor_idx", unique: true
  end

  create_table "core_host_pub_mappings", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "pub_uuid", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "uuid", null: false
    t.index ["uuid", "pub_uuid"], name: "idx_host_pub", unique: true
  end

  create_table "core_hosts", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "bogomips"
    t.bigint "cpu_id", null: false
    t.integer "cpu_speed"
    t.datetime "created_at", null: false
    t.bigint "formfactor_id", null: false
    t.bigint "host_pub_mapping_id", null: false
    t.bigint "kernel_version_id", null: false
    t.bigint "language_id", null: false
    t.bigint "myth_host_id", null: false
    t.integer "num_cpus"
    t.bigint "operating_system_id", null: false
    t.bigint "platform_id", null: false
    t.bigint "run_level_id", null: false
    t.integer "selinux_enabled"
    t.string "selinux_enforce"
    t.string "selinux_policy"
    t.string "system"
    t.integer "system_memory"
    t.integer "system_swap"
    t.datetime "updated_at", null: false
    t.bigint "vendor_id", null: false
    t.index ["cpu_id"], name: "index_core_hosts_on_cpu_id"
    t.index ["formfactor_id"], name: "index_core_hosts_on_formfactor_id"
    t.index ["host_pub_mapping_id"], name: "index_core_hosts_on_host_pub_mapping_id"
    t.index ["kernel_version_id"], name: "index_core_hosts_on_kernel_version_id"
    t.index ["language_id"], name: "index_core_hosts_on_language_id"
    t.index ["myth_host_id"], name: "index_core_hosts_on_myth_host_id"
    t.index ["operating_system_id"], name: "index_core_hosts_on_operating_system_id"
    t.index ["platform_id"], name: "index_core_hosts_on_platform_id"
    t.index ["run_level_id"], name: "index_core_hosts_on_run_level_id"
    t.index ["vendor_id"], name: "index_core_hosts_on_vendor_id"
  end

  create_table "core_kernel_versions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "kernel_version"
    t.datetime "updated_at", null: false
    t.index ["kernel_version"], name: "k_ver_idx", unique: true
  end

  create_table "core_languages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "language"
    t.datetime "updated_at", null: false
    t.index ["language"], name: "language_idx", unique: true
  end

  create_table "core_operating_systems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "os"
    t.datetime "updated_at", null: false
    t.index ["os"], name: "os_idx", unique: true
  end

  create_table "core_platforms", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "platform"
    t.datetime "updated_at", null: false
    t.index ["platform"], name: "platform_idx", unique: true
  end

  create_table "core_run_levels", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "default_runlevel"
    t.datetime "updated_at", null: false
    t.index ["default_runlevel"], name: "default_runlevel_idx", unique: true
  end

  create_table "core_submissions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.boolean "added", default: false
    t.datetime "arrival", precision: nil, default: -> { "current_timestamp()" }
    t.datetime "created_at", precision: nil, null: false
    t.text "data", null: false
    t.string "hw_uuid", null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "core_vendors", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "vendors_idx", unique: true
  end

  create_table "file_systems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.integer "f_bavail"
    t.integer "f_bfree"
    t.integer "f_blocks"
    t.integer "f_bsize"
    t.integer "f_favail"
    t.integer "f_ffree"
    t.integer "f_files"
    t.integer "f_frsize"
    t.integer "f_fssize"
    t.text "fs_type"
    t.integer "host_id"
    t.text "mnt_pnt"
  end

  create_table "host", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.decimal "bogomips", precision: 10
    t.integer "cpu_family"
    t.text "cpu_model"
    t.integer "cpu_model_num"
    t.decimal "cpu_speed", precision: 10
    t.integer "cpu_stepping"
    t.text "cpu_vendor"
    t.integer "default_runlevel"
    t.text "formfactor"
    t.text "kernel_version"
    t.text "language"
    t.timestamp "last_modified", null: false
    t.integer "num_cpus"
    t.text "os"
    t.text "platform"
    t.text "pub_uuid", null: false
    t.integer "rating", null: false
    t.integer "selinux_enabled", null: false
    t.text "selinux_enforce"
    t.text "selinux_policy"
    t.text "system"
    t.integer "system_memory"
    t.integer "system_swap"
    t.text "uuid", null: false
    t.text "vendor"
    t.index ["id", "last_modified"], name: "last_modified_join"
    t.index ["last_modified"], name: "index_host_on_last_modified"
    t.index ["platform"], name: "index_host_on_platform", length: 1024
    t.index ["pub_uuid"], name: "index_host_on_pub_uuid", unique: true, using: :hash
    t.index ["uuid"], name: "index_host_on_uuid", unique: true, using: :hash
  end

  create_table "myth_audios", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "audio_sys"
    t.string "audio_sys_version"
    t.datetime "created_at", null: false
    t.integer "defaultupmix"
    t.string "device"
    t.bigint "host_id"
    t.integer "jack"
    t.integer "maxchannels"
    t.string "mixercontrol"
    t.string "mixerdevice"
    t.string "passthru"
    t.string "passthrudevice"
    t.integer "passthruoverride"
    t.integer "pulse"
    t.integer "sr_override"
    t.integer "stereopcm"
    t.datetime "updated_at", null: false
    t.string "upmixtype"
    t.integer "volcontrol"
    t.index ["host_id"], name: "index_myth_audios_on_host_id"
  end

  create_table "myth_branches", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "branch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_countries", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "myth_databases", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "db_version_id", null: false
    t.bigint "host_id"
    t.datetime "updated_at", null: false
    t.bigint "used_engine_id"
    t.index ["db_version_id"], name: "index_myth_databases_on_db_version_id"
    t.index ["host_id"], name: "index_myth_databases_on_host_id"
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
    t.datetime "created_at", null: false
    t.string "engine"
    t.datetime "updated_at", null: false
  end

  create_table "myth_db_versions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "version"
  end

  create_table "myth_grabbers", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "grabber"
    t.datetime "updated_at", null: false
  end

  create_table "myth_grabbers_hosts", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "grabber_id"
    t.bigint "host_id"
    t.index ["grabber_id"], name: "index_myth_grabbers_hosts_on_grabber_id"
    t.index ["host_id"], name: "index_myth_grabbers_hosts_on_host_id"
  end

  create_table "myth_historicals", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "db_age"
    t.bigint "host_id"
    t.bigint "reccount"
    t.bigint "rectime"
    t.bigint "showcount"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_myth_historicals_on_host_id"
  end

  create_table "myth_hosts", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.timestamp "arrival"
    t.bigint "branch_id"
    t.integer "channelcount"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.bigint "historical_id"
    t.bigint "language_id"
    t.bigint "libapi_id"
    t.bigint "protocol_id"
    t.bigint "qt_version_id"
    t.bigint "remote_id"
    t.integer "sourcecount"
    t.bigint "theme_id"
    t.bigint "timezone_id"
    t.bigint "tzoffset_id"
    t.datetime "updated_at", null: false
    t.bigint "uuid_id"
    t.bigint "version_bucket_id"
    t.bigint "version_id"
    t.float "vtpertuner"
    t.index ["branch_id"], name: "index_myth_hosts_on_branch_id"
    t.index ["country_id"], name: "index_myth_hosts_on_country_id"
    t.index ["historical_id"], name: "index_myth_hosts_on_historical_id"
    t.index ["language_id"], name: "index_myth_hosts_on_language_id"
    t.index ["libapi_id"], name: "index_myth_hosts_on_libapi_id"
    t.index ["protocol_id"], name: "index_myth_hosts_on_protocol_id"
    t.index ["qt_version_id"], name: "index_myth_hosts_on_qt_version_id"
    t.index ["remote_id"], name: "index_myth_hosts_on_remote_id"
    t.index ["theme_id"], name: "index_myth_hosts_on_theme_id"
    t.index ["timezone_id"], name: "index_myth_hosts_on_timezone_id"
    t.index ["tzoffset_id"], name: "index_myth_hosts_on_tzoffset_id"
    t.index ["uuid_id"], name: "index_myth_hosts_on_uuid_id"
    t.index ["version_bucket_id"], name: "index_myth_hosts_on_version_bucket_id"
    t.index ["version_id"], name: "index_myth_hosts_on_version_id"
  end

  create_table "myth_languages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "language"
    t.datetime "updated_at", null: false
  end

  create_table "myth_libapis", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "libapi"
    t.datetime "updated_at", null: false
  end

  create_table "myth_logs", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "level"
    t.datetime "updated_at", null: false
    t.float "value"
  end

  create_table "myth_playback_profile_details", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "decoder"
    t.string "deint_pri"
    t.string "deint_sec"
    t.string "filters"
    t.string "renderer"
    t.datetime "updated_at", null: false
  end

  create_table "myth_playback_profile_details_profiles", id: false, charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "playback_profile_detail_id"
    t.bigint "playback_profile_id"
    t.index ["playback_profile_detail_id"], name: "idx_on_playback_profile_detail_id_e169a2ac8f"
    t.index ["playback_profile_id"], name: "idx_on_playback_profile_id_f781fcb6be"
  end

  create_table "myth_playback_profiles", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "host_id"
    t.string "profile_name"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_myth_playback_profiles_on_host_id"
  end

  create_table "myth_protocols", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "protocol"
    t.datetime "updated_at", null: false
  end

  create_table "myth_qt_versions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "qt_version"
    t.datetime "updated_at", null: false
  end

  create_table "myth_recordings", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.bigint "host_id"
    t.string "name"
    t.bigint "size"
    t.bigint "time"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_myth_recordings_on_host_id"
  end

  create_table "myth_remotes", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "remote"
    t.datetime "updated_at", null: false
  end

  create_table "myth_schedulers", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.bigint "host_id"
    t.float "match_avg"
    t.float "match_stddev"
    t.float "place_avg"
    t.float "place_stddev"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_myth_schedulers_on_host_id"
  end

  create_table "myth_schemaversions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "version"
  end

  create_table "myth_storages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "host_id"
    t.string "name"
    t.bigint "size"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_myth_storages_on_host_id"
  end

  create_table "myth_themes", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "theme"
    t.datetime "updated_at", null: false
  end

  create_table "myth_timezones", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "timezone"
    t.datetime "updated_at", null: false
  end

  create_table "myth_tuners", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "host_id"
    t.string "name"
    t.integer "tuner_count"
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_myth_tuners_on_host_id"
  end

  create_table "myth_tzoffsets", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "tzoffset"
    t.datetime "updated_at", null: false
  end

  create_table "myth_uuids", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "myth_uuid"
    t.datetime "updated_at", null: false
  end

  create_table "myth_version_buckets", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "version_bucket"
  end

  create_table "myth_versions", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "version"
  end

  create_table "stat_architectures", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_cpu_vendors", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_filesystem_types", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_kernels", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_languages", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_models", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_num_cpus", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.integer "num_cpus"
    t.datetime "updated_at", null: false
  end

  create_table "stat_operating_systems", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_run_levels", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "stat_vendors", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "count"
    t.datetime "created_at", null: false
    t.string "name"
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
