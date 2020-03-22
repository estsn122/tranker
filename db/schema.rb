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

ActiveRecord::Schema.define(version: 2020_03_22_064146) do

  create_table "followed_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "twitter_id", null: false
    t.boolean "truncation", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_id"], name: "index_followed_users_on_twitter_id", unique: true
  end

  create_table "imported_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "twitter_id", null: false
    t.date "registered_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registered_on"], name: "index_imported_users_on_registered_on"
    t.index ["twitter_id"], name: "index_imported_users_on_twitter_id", unique: true
  end

  create_table "point_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "twitter_id", null: false
    t.integer "points", null: false
    t.date "aggregated_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_id", "aggregated_on"], name: "index_point_logs_on_twitter_id_and_aggregated_on", unique: true
  end

  create_table "rankers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "twitter_id", null: false
    t.integer "points", null: false
    t.string "name"
    t.string "screen_name"
    t.text "profile"
    t.string "profile_image_url"
    t.boolean "official", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twitter_id"], name: "index_rankers_on_twitter_id", unique: true
  end

end
