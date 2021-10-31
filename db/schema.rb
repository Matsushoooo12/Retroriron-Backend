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

ActiveRecord::Schema.define(version: 2021_10_31_160203) do

  create_table "contacts", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.integer "phone"
    t.text "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discographies", force: :cascade do |t|
    t.string "title", null: false
    t.date "date", null: false
    t.string "image", null: false
    t.string "mv_link"
    t.string "subscription_link"
    t.integer "tag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lives", force: :cascade do |t|
    t.string "title", null: false
    t.date "date", null: false
    t.time "open_time"
    t.time "start_time"
    t.string "venue"
    t.string "price"
    t.text "detail"
    t.string "image"
    t.boolean "image_vertical"
    t.string "performer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ticket_link"
  end

  create_table "news", force: :cascade do |t|
    t.string "title", null: false
    t.date "date", null: false
    t.text "content", null: false
    t.string "image"
    t.boolean "image_vertical"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.string "date", null: false
    t.string "title", null: false
    t.string "name_kana", null: false
    t.integer "number", null: false
    t.string "email", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
