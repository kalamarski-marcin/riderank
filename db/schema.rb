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

ActiveRecord::Schema.define(version: 20170204161231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address"
    t.index ["address"], name: "isx_unique_address", unique: true, using: :btree
  end

  create_table "routes", force: :cascade do |t|
    t.decimal "distance",               precision: 10, scale: 2, null: false
    t.integer "start_address_id",                                null: false
    t.integer "destination_address_id",                          null: false
    t.index ["start_address_id", "destination_address_id"], name: "idx_ruoute_unique", unique: true, using: :btree
  end

  create_table "taxi_providers", force: :cascade do |t|
    t.string "name"
  end

  create_table "taxi_rides", force: :cascade do |t|
    t.datetime "date",                                                      null: false
    t.integer  "route_id"
    t.integer  "taxi_provider_id"
    t.integer  "price_cents",                               default: 0,     null: false
    t.string   "price_currency",                            default: "EUR", null: false
    t.decimal  "price",            precision: 10, scale: 2,                 null: false
    t.string   "currency",                                  default: "EUR", null: false
    t.index ["route_id"], name: "index_taxi_rides_on_route_id", using: :btree
    t.index ["taxi_provider_id"], name: "index_taxi_rides_on_taxi_provider_id", using: :btree
  end

  add_foreign_key "routes", "addresses", column: "destination_address_id", name: "fk_routes_addresses_destination_address"
  add_foreign_key "routes", "addresses", column: "start_address_id", name: "fk_routes_addresses_start_address"
  add_foreign_key "taxi_rides", "routes"
  add_foreign_key "taxi_rides", "taxi_providers"
end
