# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170528022245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ca_codes", force: :cascade do |t|
    t.string   "code_number", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code_number"], name: "index_ca_codes_on_code_number", unique: true, using: :btree
  end

  create_table "general_descriptions", force: :cascade do |t|
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["description"], name: "index_general_descriptions_on_description", unique: true, using: :btree
  end

  create_table "iso_descriptions", force: :cascade do |t|
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["description"], name: "index_iso_descriptions_on_description", unique: true, using: :btree
  end

  create_table "mappings", force: :cascade do |t|
    t.integer  "ncci_code_id"
    t.integer  "ca_code_id"
    t.integer  "naics_code_id"
    t.integer  "sic_code_id"
    t.integer  "general_description_id"
    t.integer  "iso_description_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["ca_code_id"], name: "index_mappings_on_ca_code_id", using: :btree
    t.index ["general_description_id"], name: "index_mappings_on_general_description_id", using: :btree
    t.index ["iso_description_id"], name: "index_mappings_on_iso_description_id", using: :btree
    t.index ["naics_code_id"], name: "index_mappings_on_naics_code_id", using: :btree
    t.index ["ncci_code_id", "ca_code_id", "naics_code_id", "sic_code_id", "general_description_id", "iso_description_id"], name: "by_descriptions_codes", unique: true, using: :btree
    t.index ["ncci_code_id"], name: "index_mappings_on_ncci_code_id", using: :btree
    t.index ["sic_code_id"], name: "index_mappings_on_sic_code_id", using: :btree
  end

  create_table "naics_codes", force: :cascade do |t|
    t.string   "code_number", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code_number"], name: "index_naics_codes_on_code_number", unique: true, using: :btree
  end

  create_table "ncci_codes", force: :cascade do |t|
    t.string   "code_number", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code_number"], name: "index_ncci_codes_on_code_number", unique: true, using: :btree
  end

  create_table "sic_codes", force: :cascade do |t|
    t.string   "code_number", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["code_number"], name: "index_sic_codes_on_code_number", unique: true, using: :btree
  end

end
