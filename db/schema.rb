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

ActiveRecord::Schema.define(version: 2022_02_10_123415) do

  create_table "programs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.integer "program_category_id"
    t.integer "currency_id"
    t.decimal "price", precision: 10
    t.string "program_type_id"
    t.string "status"
    t.string "url"
    t.text "description"
    t.integer "validity_period", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["currency_id"], name: "index_programs_on_currency_id"
    t.index ["program_category_id"], name: "index_programs_on_program_category_id"
    t.index ["program_type_id"], name: "index_programs_on_program_type_id"
  end

end
