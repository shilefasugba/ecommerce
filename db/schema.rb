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

ActiveRecord::Schema.define(version: 20160510151147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state_province"
    t.integer  "country_id"
    t.integer  "state_province_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "postal_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["country_id"], name: "index_addresses_on_country_id", using: :btree
  add_index "addresses", ["state_province_id"], name: "index_addresses_on_state_province_id", using: :btree
  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "order_id"
    t.integer "store_order_id"
    t.integer "store_id"
    t.integer "count",               default: 0
    t.integer "shipping_profile_id"
    t.integer "integer"
    t.integer "status",              default: 0
  end

  add_index "cart_items", ["order_id"], name: "index_cart_items_on_order_id", using: :btree
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id", using: :btree
  add_index "cart_items", ["shipping_profile_id"], name: "index_cart_items_on_shipping_profile_id", using: :btree
  add_index "cart_items", ["store_id"], name: "index_cart_items_on_store_id", using: :btree
  add_index "cart_items", ["store_order_id"], name: "index_cart_items_on_store_order_id", using: :btree
  add_index "cart_items", ["user_id"], name: "index_cart_items_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "total"
    t.decimal  "total_shipping"
    t.integer  "payment_status_id"
    t.integer  "store_id"
    t.decimal  "subtotal"
    t.decimal  "tax_total"
    t.string   "stripe_charge_id"
    t.integer  "billing_address_id"
    t.integer  "shipping_address_id"
    t.integer  "status",              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payment_status"
    t.decimal  "fee"
  end

  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id", using: :btree
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "store_id"
    t.integer  "category_id"
    t.boolean  "track_inventory",     default: false
    t.integer  "stock_count"
    t.decimal  "shipping_weight_lbs"
    t.integer  "shipping_profile_id"
    t.decimal  "price"
    t.string   "stripe_id"
    t.string   "sku"
    t.string   "slug"
    t.decimal  "tax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_urls",          default: [],    array: true
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["shipping_profile_id"], name: "index_products_on_shipping_profile_id", using: :btree
  add_index "products", ["store_id"], name: "index_products_on_store_id", using: :btree

  create_table "shipping_profiles", force: :cascade do |t|
    t.integer "shipping_type", default: 0
    t.integer "country_id"
    t.integer "product_id"
    t.integer "store_id"
    t.boolean "all_countries"
    t.decimal "base_price"
    t.decimal "per_item"
    t.decimal "extra_item"
  end

  add_index "shipping_profiles", ["country_id"], name: "index_shipping_profiles_on_country_id", using: :btree
  add_index "shipping_profiles", ["product_id"], name: "index_shipping_profiles_on_product_id", using: :btree
  add_index "shipping_profiles", ["store_id"], name: "index_shipping_profiles_on_store_id", using: :btree

  create_table "state_provinces", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "state_provinces", ["country_id"], name: "index_state_provinces_on_country_id", using: :btree

  create_table "store_orders", force: :cascade do |t|
    t.integer "order_id"
    t.integer "store_id"
    t.decimal "total"
    t.decimal "total_shipping"
    t.integer "payment_status_id"
    t.decimal "subtotal"
    t.decimal "tax_total"
    t.string  "stripe_charge_id"
    t.integer "billing_address_id"
    t.integer "shipping_address_id"
    t.integer "status",              default: 0
    t.string  "payment_status"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "stripe_id"
    t.text     "summary"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id", using: :btree

  create_table "stripe_webhook_events", force: :cascade do |t|
    t.string   "stripe_id"
    t.string   "stripe_type"
    t.hstore   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.string   "stripe_failure_code"
    t.integer  "store_order_id"
  end

  add_index "stripe_webhook_events", ["order_id"], name: "index_stripe_webhook_events_on_order_id", using: :btree
  add_index "stripe_webhook_events", ["store_order_id"], name: "index_stripe_webhook_events_on_store_order_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "users"
    t.string   "stripe_customer_token"
    t.boolean  "admin",                  default: false
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
