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

ActiveRecord::Schema.define(version: 20161126093433) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculated_variables", force: :cascade do |t|
    t.integer "task_id"
    t.string  "name",    null: false
    t.string  "formula"
    t.index ["task_id"], name: "index_calculated_variables_on_task_id", using: :btree
  end

  create_table "generated_tasks", force: :cascade do |t|
    t.integer "task_id"
    t.integer "task_in_card", null: false
    t.integer "variant_id"
    t.index ["task_id"], name: "index_generated_tasks_on_task_id", using: :btree
    t.index ["variant_id"], name: "index_generated_tasks_on_variant_id", using: :btree
  end

  create_table "generated_variables", force: :cascade do |t|
    t.integer "generated_task_id"
    t.integer "variable_id"
    t.float   "value",             null: false
    t.index ["generated_task_id"], name: "index_generated_variables_on_generated_task_id", using: :btree
    t.index ["variable_id"], name: "index_generated_variables_on_variable_id", using: :btree
  end

  create_table "generations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_card_id"
    t.string   "title"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["question_card_id"], name: "index_generations_on_question_card_id", using: :btree
    t.index ["user_id"], name: "index_generations_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file",       limit: 256, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["user_id"], name: "index_images_on_user_id", using: :btree
  end

  create_table "question_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.string   "title",                                                              null: false
    t.text     "description"
    t.text     "question_card", default: "<h1>Вариант № $V</h1><p>Текст билета</p>", null: false
    t.boolean  "removed",       default: false
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.index ["user_id"], name: "index_question_cards_on_user_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                       null: false
    t.text     "description"
    t.text     "task",                        null: false
    t.text     "answer"
    t.string   "subject"
    t.boolean  "removed",     default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_tasks_on_user_id", using: :btree
  end

  create_table "tasks_and_groups", id: false, force: :cascade do |t|
    t.integer "tasks_group_id"
    t.integer "task_id"
    t.index ["task_id"], name: "index_tasks_and_groups_on_task_id", using: :btree
    t.index ["tasks_group_id", "task_id"], name: "index_tasks_and_groups_on_tasks_group_id_and_task_id", unique: true, using: :btree
    t.index ["tasks_group_id"], name: "index_tasks_and_groups_on_tasks_group_id", using: :btree
  end

  create_table "tasks_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.string   "title",                       null: false
    t.text     "description"
    t.boolean  "removed",     default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_tasks_groups_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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

  create_table "variables", force: :cascade do |t|
    t.integer "task_id"
    t.string  "name",    null: false
    t.float   "from",    null: false
    t.float   "to",      null: false
    t.integer "round"
    t.index ["task_id"], name: "index_variables_on_task_id", using: :btree
  end

  create_table "variants", force: :cascade do |t|
    t.integer "number",        null: false
    t.integer "generation_id"
    t.index ["generation_id"], name: "index_variants_on_generation_id", using: :btree
  end

end
