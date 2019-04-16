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

ActiveRecord::Schema.define(version: 20190416162802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.bigint "block_id"
    t.string "block_type"
    t.text "block_text"
    t.string "image_url"
    t.bigint "stored_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stored_product_id"], name: "index_blocks_on_stored_product_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "image_url"
    t.bigint "stored_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shopify_id"
    t.index ["stored_product_id"], name: "index_product_images_on_stored_product_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "language", default: "en"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "stored_products", force: :cascade do |t|
    t.string "shopify_id"
    t.string "shopify_title"
    t.string "shopify_image_url"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "lookbook_html"
    t.string "shopify_handle"
    t.index ["shop_id"], name: "index_stored_products_on_shop_id"
  end

  add_foreign_key "blocks", "stored_products"
  add_foreign_key "product_images", "stored_products"
  add_foreign_key "stored_products", "shops"
end
