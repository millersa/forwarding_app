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

ActiveRecord::Schema.define(:version => 20120516030928) do

  create_table "assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categorizations", :force => true do |t|
    t.integer  "raztentovka_id"
    t.integer  "driver_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "organization"
    t.string   "contlico"
    t.string   "phone"
    t.text     "gruz"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  add_index "companies", ["user_id"], :name => "index_companies_on_user_id"

  create_table "drivers", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "oname"
    t.string   "phone"
    t.string   "contacts"
    t.integer  "ves"
    t.integer  "objem"
    t.string   "gosnomerp"
    t.string   "gosnomer"
    t.integer  "seriy"
    t.integer  "nomerp"
    t.string   "kemvidan"
    t.string   "kogdavidan"
    t.string   "tipkuzova"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "marka_id"
  end

  create_table "markas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "raztentovkas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "tenders", :force => true do |t|
    t.string   "price"
    t.integer  "driver_id"
    t.integer  "company_id"
    t.string   "form_oplata"
    t.string   "route"
    t.string   "adress_pogruzka"
    t.date     "date_pogruzki"
    t.time     "vremy_pogruzki"
    t.string   "gruzotpravitel"
    t.string   "adress_razgruzki"
    t.date     "data_razgruzki"
    t.time     "vremy_razgruzlki"
    t.string   "gruzopoluhatel"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "user_id"
    t.boolean  "status",           :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "otchestvo"
    t.string   "sex"
    t.date     "datebirth"
    t.string   "doljnost"
    t.date     "datework"
    t.integer  "seriy"
    t.integer  "nomer"
    t.string   "vidan"
    t.string   "phone"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "encrypted_password"
    t.string   "remember_token"
    t.string   "password_digest"
    t.string   "role"
    t.integer  "roles_mask"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
