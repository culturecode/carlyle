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

ActiveRecord::Schema.define(version: 20140804215815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crier_listenings", force: :cascade do |t|
    t.integer "notification_id"
    t.integer "user_id"
  end

  add_index "crier_listenings", ["notification_id"], name: "index_crier_listenings_on_notification_id", using: :btree
  add_index "crier_listenings", ["user_id"], name: "index_crier_listenings_on_user_id", using: :btree

  create_table "crier_notifications", force: :cascade do |t|
    t.string   "scope"
    t.text     "message"
    t.integer  "crier_id"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "action"
    t.text     "metadata"
    t.boolean  "private",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crier_notifications", ["scope"], name: "index_crier_notifications_on_scope", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "document_type"
    t.string   "attachment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
    t.date     "date"
  end

  add_index "documents", ["date"], name: "index_documents_on_date", using: :btree

  create_table "lockers", force: :cascade do |t|
    t.integer  "number"
    t.string   "location"
    t.text     "description"
    t.integer  "suite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suite_people", force: :cascade do |t|
    t.integer "person_id"
    t.integer "suite_id"
    t.string  "relationship"
  end

  create_table "suites", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
