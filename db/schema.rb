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

ActiveRecord::Schema.define(version: 20150416115506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calendars", force: :cascade do |t|
    t.string   "schedule"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "league_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string   "league_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "number_of_teams"
    t.integer  "user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string   "match_name"
    t.integer  "first_team_score"
    t.integer  "second_team_score"
    t.integer  "league_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "games_played"
    t.integer  "wins"
    t.integer  "draws"
    t.integer  "defeats"
    t.integer  "goals_scored"
    t.integer  "goals_lost"
    t.integer  "goals_difference"
    t.integer  "points"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "team_name"
    t.integer  "league_id"
    t.integer  "position"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "profile_name"
    t.boolean  "admin",                  default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
