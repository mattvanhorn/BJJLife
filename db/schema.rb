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

ActiveRecord::Schema.define(:version => 20130419014910) do

  create_table "academies", :force => true do |t|
    t.string   "name",                                :null => false
    t.string   "instructor"
    t.string   "website"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "state",        :default => "pending"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "identities", :force => true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "identities", ["email"], :name => "index_identities_on_email", :unique => true
  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"

  create_table "journal_entries", :force => true do |t|
    t.integer  "journal_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "journal_entries", ["journal_id"], :name => "index_journal_entries_on_journal_id"

  create_table "journals", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "journals", ["user_id"], :name => "index_journals_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "type",                                                         :default => "Location", :null => false
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.decimal  "lat",                          :precision => 15, :scale => 10
    t.decimal  "lng",                          :precision => 15, :scale => 10
    t.string   "ip_address",     :limit => 45
    t.string   "street"
    t.string   "unit"
    t.string   "city"
    t.string   "us_state",       :limit => 2
    t.string   "postal_code"
    t.string   "country"
    t.datetime "created_at",                                                                           :null => false
    t.datetime "updated_at",                                                                           :null => false
  end

  add_index "locations", ["locatable_id", "locatable_type"], :name => "index_locations_on_locatable_id_and_locatable_type"
  add_index "locations", ["type"], :name => "index_locations_on_type"

  create_table "markets", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft",                      :null => false
    t.integer "rgt",                      :null => false
    t.integer "depth",     :default => 0, :null => false
  end

  add_index "markets", ["parent_id"], :name => "index_markets_on_parent_id"

  create_table "order_adjustments", :force => true do |t|
    t.integer  "order_id"
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "order_adjustments", ["order_id"], :name => "index_order_adjustments_on_order_id"

  create_table "order_items", :force => true do |t|
    t.integer  "order_id",                  :null => false
    t.integer  "product_id",                :null => false
    t.integer  "quantity",   :default => 1, :null => false
    t.integer  "unit_price",                :null => false
    t.integer  "adjustment", :default => 0, :null => false
    t.integer  "price",                     :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], :name => "index_order_items_on_product_id"

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "charge_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "order_transactions", ["order_id"], :name => "index_order_transactions_on_order_id"

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "state"
    t.string   "bill_first_name",  :limit => 32
    t.string   "bill_last_name",   :limit => 32
    t.string   "bill_street"
    t.string   "bill_unit"
    t.string   "bill_city"
    t.string   "bill_us_state",    :limit => 2
    t.string   "bill_postal_code", :limit => 10
    t.string   "email"
    t.string   "cc_type"
    t.integer  "cc_exp_month"
    t.integer  "cc_exp_year"
    t.string   "cc_last4",         :limit => 4
    t.string   "cc_fingerprint"
    t.string   "cc_country"
    t.string   "currency",         :limit => 3,  :default => "usd", :null => false
    t.integer  "amount",                                            :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nickname"
    t.integer  "rank"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "blog_id"
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "user_id"
    t.integer  "up_votes",    :default => 0, :null => false
    t.integer  "down_votes",  :default => 0, :null => false
  end

  add_index "posts", ["blog_id"], :name => "index_posts_on_blog_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "photo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.integer  "category_id"
    t.integer  "market_id"
  end

  add_index "products", ["category_id"], :name => "index_products_on_category_id"
  add_index "products", ["market_id"], :name => "index_products_on_market_id"

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "redemption_codes", :force => true do |t|
    t.integer  "order_item_id", :null => false
    t.string   "token",         :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "redemption_codes", ["order_item_id"], :name => "index_redemption_codes_on_order_item_id"

  create_table "subscriptions", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "subscriptions", ["email"], :name => "index_subscriptions_on_email", :unique => true
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",      :limit => 32
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "sign_in_count",               :default => 0, :null => false
    t.integer  "up_votes",                    :default => 0, :null => false
    t.integer  "down_votes",                  :default => 0, :null => false
    t.string   "teacher"
    t.string   "rank"
    t.integer  "market_id"
  end

  add_index "users", ["market_id"], :name => "index_users_on_market_id"

  create_table "videos", :force => true do |t|
    t.string   "name",                                 :null => false
    t.string   "url",                                  :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "thumbnail_url"
    t.string   "state",         :default => "pending"
    t.integer  "up_votes",      :default => 0,         :null => false
    t.integer  "down_votes",    :default => 0,         :null => false
  end

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
