# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090104011955) do

  create_table "alarm_orders", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alarm_period_warnings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alarm_type_warnings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alarm_type_warnings_alarms", :id => false, :force => true do |t|
    t.integer  "alarm_type_warning_id"
    t.integer  "alarm_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alarms", :force => true do |t|
    t.integer  "alarm_period_warning_id"
    t.integer  "alarm_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.string   "text"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "person_type_id"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_types", :force => true do |t|
    t.string   "document"
    t.string   "fields"
    t.integer  "contract_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", :force => true do |t|
    t.integer  "contract_category_id"
    t.integer  "contract_type_id"
    t.integer  "user_id"
    t.string   "contract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "person_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "name"
    t.string   "email"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
