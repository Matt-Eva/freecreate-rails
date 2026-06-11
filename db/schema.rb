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

ActiveRecord::Schema[8.1].define(version: 2026_06_11_020814) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "chapters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "never_published", default: true, null: false
    t.integer "number"
    t.datetime "originally_published"
    t.boolean "published"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.bigint "writing_id", null: false
    t.index ["user_id"], name: "index_chapters_on_user_id"
    t.index ["uuid"], name: "index_chapters_on_uuid"
    t.index ["writing_id"], name: "index_chapters_on_writing_id"
  end

  create_table "collections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.string "tags", default: [], null: false, array: true
    t.string "title"
    t.string "topics", default: [], null: false, array: true
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["creator_id"], name: "index_collections_on_creator_id"
    t.index ["topics", "tags"], name: "index_collections_on_topics_and_tags", using: :gin
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "creator_genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_creator_genres_on_creator_id"
    t.index ["genre_id"], name: "index_creator_genres_on_genre_id"
  end

  create_table "creator_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_creator_tags_on_creator_id"
    t.index ["tag_id"], name: "index_creator_tags_on_tag_id"
  end

  create_table "creators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.index ["user_id", "name"], name: "index_creators_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_creators_on_user_id"
    t.index ["uuid"], name: "index_creators_on_uuid"
  end

  create_table "genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "genre"
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "tag"
    t.datetime "updated_at", null: false
    t.index ["tag"], name: "index_tags_on_tag"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.boolean "is_adult"
    t.string "password_digest", null: false
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "writing_genres", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "genre_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "writing_id", null: false
    t.index ["genre_id"], name: "index_writing_genres_on_genre_id"
    t.index ["writing_id"], name: "index_writing_genres_on_writing_id"
  end

  create_table "writing_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "writing_id", null: false
    t.index ["tag_id"], name: "index_writing_tags_on_tag_id"
    t.index ["writing_id"], name: "index_writing_tags_on_writing_id"
  end

  create_table "writings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "creator_id", null: false
    t.text "description"
    t.bigint "donations", default: 0
    t.bigint "flags", default: 0
    t.datetime "last_published"
    t.bigint "lib_adds", default: 0
    t.bigint "likes", default: 0
    t.bigint "list_adds", default: 0
    t.boolean "never_published", default: true, null: false
    t.boolean "published", default: false
    t.bigint "rank", default: 0
    t.integer "rank_tracker", default: 0
    t.bigint "rel_rank", default: 0
    t.string "tags", default: [], null: false, array: true
    t.string "title"
    t.string "topics", default: ["No Topic"], null: false, array: true
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }
    t.bigint "views", default: 1
    t.string "writing_type", default: "Short Story", null: false
    t.index ["creator_id"], name: "index_writings_on_creator_id"
    t.index ["last_published"], name: "index_writings_on_last_published"
    t.index ["rank"], name: "index_writings_on_rank"
    t.index ["rel_rank"], name: "index_writings_on_rel_rank"
    t.index ["topics", "tags"], name: "index_writings_on_topics_and_tags", using: :gin
    t.index ["user_id"], name: "index_writings_on_user_id"
    t.index ["uuid"], name: "index_writings_on_uuid"
    t.index ["writing_type"], name: "index_writings_on_writing_type"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chapters", "users"
  add_foreign_key "chapters", "writings"
  add_foreign_key "collections", "creators"
  add_foreign_key "collections", "users"
  add_foreign_key "creator_genres", "creators"
  add_foreign_key "creator_genres", "genres"
  add_foreign_key "creator_tags", "creators"
  add_foreign_key "creator_tags", "tags"
  add_foreign_key "creators", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "writing_genres", "genres"
  add_foreign_key "writing_genres", "writings"
  add_foreign_key "writing_tags", "tags"
  add_foreign_key "writing_tags", "writings"
  add_foreign_key "writings", "creators"
  add_foreign_key "writings", "users"
end
