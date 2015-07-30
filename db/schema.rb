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

ActiveRecord::Schema.define(version: 20150615010632) do

  create_table "herba_addresses", force: :cascade do |t|
    t.integer  "herba_client_id", limit: 4
    t.string   "zip_code",        limit: 10
    t.string   "street",          limit: 255
    t.string   "number",          limit: 10
    t.string   "neighborhood",    limit: 255
    t.string   "city",            limit: 100
    t.string   "state",           limit: 50
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "herba_addresses", ["herba_client_id"], name: "index_herba_addresses_on_herba_client_id", using: :btree

  create_table "herba_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "herba_clients", force: :cascade do |t|
    t.integer  "herba_title_id", limit: 4
    t.string   "name",           limit: 255
    t.string   "email",          limit: 100
    t.string   "phone",          limit: 20
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "herba_clients", ["herba_title_id"], name: "index_herba_clients_on_herba_title_id", using: :btree

  create_table "herba_incomes", force: :cascade do |t|
    t.integer  "herba_client_id", limit: 4
    t.decimal  "value",                       precision: 10, scale: 2
    t.string   "mode",            limit: 10
    t.string   "description",     limit: 255
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "herba_incomes", ["herba_client_id"], name: "index_herba_incomes_on_herba_client_id", using: :btree

  create_table "herba_items", force: :cascade do |t|
    t.integer  "herba_client_id",  limit: 4
    t.integer  "herba_product_id", limit: 4
    t.decimal  "price",                      precision: 10, scale: 2
    t.decimal  "profit",                     precision: 10, scale: 2
    t.date     "delivery_date"
    t.date     "payment_date"
    t.date     "product_date"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  add_index "herba_items", ["herba_client_id"], name: "index_herba_items_on_herba_client_id", using: :btree
  add_index "herba_items", ["herba_product_id"], name: "index_herba_items_on_herba_product_id", using: :btree

  create_table "herba_products", force: :cascade do |t|
    t.integer  "herba_category_id", limit: 4
    t.string   "code",              limit: 10
    t.string   "name",              limit: 255
    t.decimal  "price",                         precision: 10, scale: 2
    t.integer  "portion",           limit: 4
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
  end

  add_index "herba_products", ["herba_category_id"], name: "index_herba_products_on_herba_category_id", using: :btree

  create_table "herba_profiles", force: :cascade do |t|
    t.integer  "herba_client_id", limit: 4
    t.float    "weight",          limit: 24
    t.float    "chest",           limit: 24
    t.float    "rib",             limit: 24
    t.float    "belly",           limit: 24
    t.float    "hip",             limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "herba_profiles", ["herba_client_id"], name: "index_herba_profiles_on_herba_client_id", using: :btree

  create_table "herba_titles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "discount",   limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "herba_transactions", force: :cascade do |t|
    t.integer  "herba_client_id", limit: 4
    t.decimal  "value",                       precision: 10, scale: 2
    t.string   "mode",            limit: 10
    t.string   "description",     limit: 255
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

  add_index "herba_transactions", ["herba_client_id"], name: "index_herba_transactions_on_herba_client_id", using: :btree

  create_table "home_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "home_clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "home_transactions", force: :cascade do |t|
    t.integer  "home_client_id",   limit: 4
    t.integer  "home_category_id", limit: 4
    t.decimal  "value",                        precision: 10, scale: 2
    t.string   "mode",             limit: 10
    t.string   "description",      limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  add_index "home_transactions", ["home_category_id"], name: "index_home_transactions_on_home_category_id", using: :btree
  add_index "home_transactions", ["home_client_id"], name: "index_home_transactions_on_home_client_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
