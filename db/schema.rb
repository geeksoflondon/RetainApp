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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120701134550) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "attendees", :force => true do |t|
    t.integer  "event_id"
    t.integer  "ticket_id"
    t.string   "status"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "twitter"
    t.string   "t_shirt"
    t.string   "diet"
    t.string   "badge"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "public_profile"
    t.string   "barcode"
    t.text     "notes"
  end

  add_index "attendees", ["event_id"], :name => "index_attendees_on_event_id"
  add_index "attendees", ["ticket_id"], :name => "index_attendees_on_ticket_id"

  create_table "checkins", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "event_id"
    t.boolean  "onsite"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "attended",    :default => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.date     "start"
    t.date     "end"
    t.string   "venue"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "event_url"
    t.string   "venue_url"
    t.string   "eventbrite_id"
  end

  create_table "oneclicks", :force => true do |t|
    t.integer  "attendee_id"
    t.string   "token"
    t.boolean  "used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "trackings", :force => true do |t|
    t.integer  "attendee_id"
    t.integer  "event_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
