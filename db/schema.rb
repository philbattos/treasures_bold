# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140328185046) do

  create_table "landings", force: true do |t|
    t.integer  "feature_id"
    t.string   "feature_name"
    t.string   "feature_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "county"
    t.string   "lat_degrees"
    t.string   "long_degrees"
    t.decimal  "lat_decimal"
    t.decimal  "long_decimal"
    t.integer  "elev_in_meters"
    t.integer  "elevation"
    t.string   "map_name"
  end

  create_table "queries", force: true do |t|
    t.string   "verbatim"
    t.text     "terms",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "entries"
    t.string   "filters"
  end

  add_index "queries", ["user_id"], name: "index_queries_on_user_id"

  create_table "remarks", force: true do |t|
    t.string   "name"
    t.string   "email",      null: false
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
