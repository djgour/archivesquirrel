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

ActiveRecord::Schema.define(version: 20160305215034) do

  create_table "invitations", force: true do |t|
    t.integer  "invitee_id"
    t.integer  "inviter_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["invitee_id"], name: "index_invitations_on_invitee_id"
  add_index "invitations", ["inviter_id"], name: "index_invitations_on_inviter_id"
  add_index "invitations", ["project_id"], name: "index_invitations_on_project_id"

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "level"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "user_id"
  end

  add_index "items", ["project_id"], name: "index_items_on_project_id"
  add_index "items", ["user_id"], name: "index_items_on_user_id"

  create_table "participates", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participates", ["project_id"], name: "index_participates_on_project_id"
  add_index "participates", ["user_id"], name: "index_participates_on_user_id"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "password_digest"
    t.text     "description"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
