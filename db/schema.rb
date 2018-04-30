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

ActiveRecord::Schema.define(version: 20180430132619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.integer  "display_order"
    t.boolean  "order_flag",     default: false, null: false
    t.boolean  "outsource_flag", default: false, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "drawing_categories", force: :cascade do |t|
    t.integer  "drawing_id"
    t.integer  "category_id"
    t.integer  "display_order"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["category_id"], name: "index_drawing_categories_on_category_id", using: :btree
    t.index ["drawing_id"], name: "index_drawing_categories_on_drawing_id", using: :btree
  end

  create_table "drawing_files", force: :cascade do |t|
    t.integer  "drawing_id"
    t.integer  "display_order"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.index ["drawing_id"], name: "index_drawing_files_on_drawing_id", using: :btree
  end

  create_table "drawing_outsources", force: :cascade do |t|
    t.integer  "drawing_id"
    t.integer  "customer_id"
    t.integer  "purchase_price"
    t.integer  "display_order"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["customer_id"], name: "index_drawing_outsources_on_customer_id", using: :btree
    t.index ["drawing_id"], name: "index_drawing_outsources_on_drawing_id", using: :btree
  end

  create_table "drawings", force: :cascade do |t|
    t.string   "part_number"
    t.date     "order_date"
    t.integer  "estimated_price"
    t.integer  "difficulty"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "customer_id"
    t.string   "product_name"
    t.float    "thickness"
    t.float    "width"
    t.float    "length"
    t.date     "estimate_date"
    t.boolean  "estimate_flag",      default: false, null: false
    t.boolean  "order_flag",         default: false, null: false
    t.boolean  "suspend_flag",       default: false, null: false
    t.integer  "material_cost"
    t.integer  "process_cost"
    t.integer  "sales_price"
    t.text     "memo"
    t.string   "file"
    t.integer  "material_id"
    t.integer  "processing_type_id"
    t.index ["customer_id"], name: "index_drawings_on_customer_id", using: :btree
    t.index ["material_id"], name: "index_drawings_on_material_id", using: :btree
    t.index ["processing_type_id"], name: "index_drawings_on_processing_type_id", using: :btree
  end

  create_table "materials", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "create_user_id"
    t.integer  "update_user_id"
    t.index ["create_user_id"], name: "index_materials_on_create_user_id", using: :btree
    t.index ["update_user_id"], name: "index_materials_on_update_user_id", using: :btree
  end

  create_table "notices", force: :cascade do |t|
    t.string   "title"
    t.string   "body"
    t.datetime "post_datetime"
    t.integer  "create_user_id"
    t.integer  "update_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["create_user_id"], name: "index_notices_on_create_user_id", using: :btree
    t.index ["update_user_id"], name: "index_notices_on_update_user_id", using: :btree
  end

  create_table "processing_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "display_order"
    t.integer  "create_user_id"
    t.integer  "update_user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["create_user_id"], name: "index_processing_types_on_create_user_id", using: :btree
    t.index ["update_user_id"], name: "index_processing_types_on_update_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                  default: false, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "furigana"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "drawing_categories", "categories"
  add_foreign_key "drawing_categories", "drawings"
  add_foreign_key "drawing_files", "drawings"
  add_foreign_key "drawing_outsources", "customers"
  add_foreign_key "drawing_outsources", "drawings"
  add_foreign_key "drawings", "customers"
  add_foreign_key "drawings", "materials"
  add_foreign_key "drawings", "processing_types"
  add_foreign_key "materials", "users", column: "create_user_id"
  add_foreign_key "materials", "users", column: "update_user_id"
  add_foreign_key "notices", "users", column: "create_user_id"
  add_foreign_key "notices", "users", column: "update_user_id"
  add_foreign_key "processing_types", "users", column: "create_user_id"
  add_foreign_key "processing_types", "users", column: "update_user_id"
end
