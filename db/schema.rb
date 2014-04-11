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

ActiveRecord::Schema.define(version: 20140411201936) do

  create_table "blacklists", force: true do |t|
    t.string   "email_to"
    t.string   "email_from"
    t.boolean  "global"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", force: true do |t|
    t.boolean  "read",       default: false
    t.boolean  "archived",   default: false
    t.boolean  "answered",   default: false
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.string   "sender"
    t.string   "recipient"
    t.string   "subject"
    t.text     "body_plain"
    t.text     "body_html"
    t.text     "stripped_html"
    t.boolean  "answered",        default: false
    t.boolean  "read",            default: false
    t.boolean  "archived",        default: false
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cc"
    t.string   "bcc"
    t.boolean  "spam",            default: false
  end

  create_table "spams", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tokens", force: true do |t|
    t.integer  "user_id"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "image"
    t.string   "password_salt"
    t.string   "password_hash"
    t.boolean  "active",              default: false
    t.boolean  "admin",               default: false
    t.boolean  "first_login",         default: true
    t.boolean  "deleted",             default: false
    t.integer  "sign_in_count",       default: 0
    t.datetime "last_sign_in_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
