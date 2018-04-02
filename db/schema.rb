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

ActiveRecord::Schema.define(version: 20180402132645) do

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.integer "thread_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "topic_id"
    t.string "description"
    t.string "photo"
    t.index ["topic_id"], name: "index_boards_on_topic_id"
  end

  create_table "boardthreads", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "board_id"
    t.integer "user_id"
    t.integer "post_count"
    t.integer "status"
    t.integer "threadtype"
    t.index ["board_id"], name: "index_boardthreads_on_board_id"
    t.index ["user_id"], name: "index_boardthreads_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "boardthread_id"
    t.integer "user_id"
    t.index ["boardthread_id"], name: "index_posts_on_boardthread_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "about"
    t.date "birthdate"
    t.string "hometown"
    t.string "present_location"
    t.integer "role"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.integer "post_count"
    t.text "skype"
    t.text "website"
    t.integer "gender"
    t.text "interests"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
