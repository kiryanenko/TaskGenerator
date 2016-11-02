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

ActiveRecord::Schema.define(version: 20161101140930) do

  create_table "calculated_variables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "task"
    t.string   "name"
    t.integer  "type"
    t.string   "formula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dimensions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "variable_type"
    t.integer  "exponent"
    t.string   "dimension"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "generated_tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "task_id"
    t.integer  "task_in_card"
    t.integer  "variant_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "generated_variables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "generated_task"
    t.integer  "variable"
    t.float    "value",          limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "generations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "question_card_id"
    t.integer  "page_layout_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.boolean  "orientation"
  end

  create_table "page_layouts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "page_layout"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "question_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user"
    t.integer  "subject"
    t.string   "title"
    t.text     "description",   limit: 65535
    t.text     "question_card", limit: 65535
    t.datetime "date"
    t.boolean  "removed"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "subject"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user"
    t.string   "title"
    t.text     "description", limit: 65535
    t.text     "task",        limit: 65535
    t.text     "answer",      limit: 65535
    t.integer  "subject"
    t.datetime "date"
    t.boolean  "removed",                   default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "tasks_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "users_id"
    t.integer  "subject"
    t.string   "title"
    t.text     "description", limit: 65535
    t.boolean  "removed",                   default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["users_id"], name: "index_tasks_groups_on_users_id", using: :btree
  end

  create_table "tasks_groups_tasks", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tasks_groups_id"
    t.integer "tasks_id"
    t.index ["tasks_groups_id"], name: "index_tasks_groups_tasks_on_tasks_groups_id", using: :btree
    t.index ["tasks_id"], name: "index_tasks_groups_tasks_on_tasks_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "variable_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "task_id"
    t.string   "name"
    t.integer  "type"
    t.float    "from",           limit: 24
    t.integer  "dimension_from"
    t.float    "to",             limit: 24
    t.integer  "dimension_to"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "variants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "number"
    t.integer  "generation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
