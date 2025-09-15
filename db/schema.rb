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

ActiveRecord::Schema[8.0].define(version: 2025_09_15_183437) do
  create_table "batch_queue", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.timestamp "arrival", default: -> { "current_timestamp()" }
    t.integer "added", null: false
    t.string "hw_uuid", null: false
    t.text "data"
  end

  create_table "core_cpus", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
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
  end

  create_table "core_device_classes", charset: "utf8mb3", collation: "utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_devices", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.integer "vendor_id", null: false
    t.integer "device_id", null: false
    t.integer "subsys_vendor_id"
    t.integer "subsys_device_id"
    t.string "device_bus", default: "Unknown"
    t.string "device_type", default: "Unknown"
    t.string "description", default: ""
    t.string "device_driver", default: "Unknown"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["vendor_id", "device_id", "subsys_vendor_id", "subsys_device_id"], name: "idx_devices", unique: true
  end

  create_table "core_host_pub_mappings", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "pub_uuid", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["uuid", "pub_uuid"], name: "idx_host_pub", unique: true
  end

  create_table "core_operating_systems", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.text "os"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_platforms", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
    t.text "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "core_submissions", charset: "latin1", collation: "latin1_swedish_ci", force: :cascade do |t|
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

  add_foreign_key "file_systems", "host", column: "id"
end
