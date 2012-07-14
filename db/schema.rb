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

ActiveRecord::Schema.define(:version => 20120614161414) do

  create_table "admins", :force => true do |t|
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

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "broadcast_reads", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "broadcast_id"
  end

  add_index "broadcast_reads", ["user_id", "broadcast_id"], :name => "index_broadcast_reads_on_user_id_and_broadcast_id", :unique => true

  create_table "broadcasts", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "expiry"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "broadcasts", ["expiry"], :name => "index_broadcasts_on_expiry"

  create_table "invitations", :force => true do |t|
    t.integer  "organization_id"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "invitations", ["organization_id"], :name => "index_invitations_on_organization_id"
  add_index "invitations", ["token"], :name => "index_invitations_on_token"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "memberships", ["user_id", "organization_id"], :name => "index_memberships_on_user_id_and_organization_id"

  create_table "notifications", :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  add_index "notifications", ["project_id"], :name => "index_notifications_on_project_id"
  add_index "notifications", ["user_id", "project_id"], :name => "index_notifications_on_user_id_and_project_id", :unique => true
  add_index "notifications", ["user_id"], :name => "index_notifications_on_user_id"

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "participations", :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  add_index "participations", ["project_id"], :name => "index_participations_on_project_id"
  add_index "participations", ["user_id", "project_id"], :name => "index_participations_on_user_id_and_project_id"

  create_table "projects", :force => true do |t|
    t.date    "start"
    t.date    "end"
    t.boolean "active"
    t.string  "name"
    t.string  "guest_token"
    t.integer "organization_id"
    t.string  "api_token"
    t.string  "state"
  end

  add_index "projects", ["api_token"], :name => "index_projects_on_api_token"
  add_index "projects", ["guest_token"], :name => "index_projects_on_guest_token"
  add_index "projects", ["organization_id"], :name => "index_projects_on_organization_id"

  create_table "statuses", :force => true do |t|
    t.text     "text"
    t.string   "link"
    t.string   "source"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "statuses", ["project_id"], :name => "index_statuses_on_project_id"

  create_table "users", :force => true do |t|
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
    t.string   "name"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
