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

ActiveRecord::Schema.define(version: 20151114072904) do

  create_table "payment_users", force: :cascade do |t|
    t.integer "payment_id"
    t.integer "user_id"
  end

  add_index "payment_users", ["payment_id"], name: "index_payment_users_on_payment_id"
  add_index "payment_users", ["user_id"], name: "index_payment_users_on_user_id"

  create_table "payments", force: :cascade do |t|
    t.integer  "recipient_id"
    t.integer  "sender_id"
    t.decimal  "amount",       precision: 16, scale: 2
    t.text     "note"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.boolean  "paid",                                  default: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "role",            default: "user"
  end

end
