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

ActiveRecord::Schema.define(version: 2020_12_26_021951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name", default: "NewAlbum", null: false
    t.string "description"
    t.boolean "publish", default: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_albums", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_favorite_albums_on_album_id"
    t.index ["user_id"], name: "index_favorite_albums_on_user_id"
  end

  create_table "favorite_pictures", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "picture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_favorite_pictures_on_picture_id"
    t.index ["user_id"], name: "index_favorite_pictures_on_user_id"
  end

  create_table "mylists", force: :cascade do |t|
    t.bigint "picture_id", null: false
    t.bigint "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_mylists_on_album_id"
    t.index ["picture_id"], name: "index_mylists_on_picture_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "name", default: "NewPicture", null: false
    t.string "description"
    t.string "image", null: false
    t.boolean "publish"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "NewUser"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "activated", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favorite_albums", "albums"
  add_foreign_key "favorite_albums", "users"
  add_foreign_key "favorite_pictures", "pictures"
  add_foreign_key "favorite_pictures", "users"
  add_foreign_key "mylists", "albums"
  add_foreign_key "mylists", "pictures"
end
