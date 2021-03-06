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

ActiveRecord::Schema.define(version: 20160313034541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "note_categories", force: :cascade do |t|
    t.integer  "note_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "note_categories", ["category_id"], name: "index_note_categories_on_category_id", using: :btree
  add_index "note_categories", ["note_id"], name: "index_note_categories_on_note_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notes", ["user_id"], name: "index_notes_on_user_id", using: :btree

  create_table "snippet_categories", force: :cascade do |t|
    t.integer  "snippet_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "snippet_categories", ["category_id"], name: "index_snippet_categories_on_category_id", using: :btree
  add_index "snippet_categories", ["snippet_id"], name: "index_snippet_categories_on_snippet_id", using: :btree

  create_table "snippets", force: :cascade do |t|
    t.string   "title"
    t.text     "block"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.boolean  "is_private"
    t.text     "description"
  end

  add_index "snippets", ["user_id"], name: "index_snippets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "snippet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_up"
  end

  add_index "votes", ["snippet_id"], name: "index_votes_on_snippet_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "note_categories", "categories"
  add_foreign_key "note_categories", "notes"
  add_foreign_key "notes", "users"
  add_foreign_key "snippet_categories", "categories"
  add_foreign_key "snippet_categories", "snippets"
  add_foreign_key "snippets", "users"
  add_foreign_key "votes", "snippets"
  add_foreign_key "votes", "users"
end
