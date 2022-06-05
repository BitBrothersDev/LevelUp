# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_05_121056) do
  create_table "job_functions", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "learning_materials", charset: "utf8mb4", force: :cascade do |t|
    t.integer "material_type"
    t.string "name"
    t.string "link"
    t.integer "learnable_id"
    t.string "learnable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "material_containers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "job_function_id", null: false
    t.bigint "level_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_function_id"], name: "index_material_containers_on_job_function_id"
    t.index ["level_id"], name: "index_material_containers_on_level_id"
  end

  create_table "skill_categories", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "parent_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_levels", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "skill_id", null: false
    t.bigint "level_id", null: false
    t.string "notice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "index_skill_levels_on_level_id"
    t.index ["skill_id"], name: "index_skill_levels_on_skill_id"
  end

  create_table "skills", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "skill_category_id"
    t.index ["skill_category_id"], name: "index_skills_on_skill_category_id"
  end

  add_foreign_key "material_containers", "job_functions"
  add_foreign_key "material_containers", "levels"
  add_foreign_key "skill_levels", "levels"
  add_foreign_key "skill_levels", "skills"
end
