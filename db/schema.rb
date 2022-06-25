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

ActiveRecord::Schema[7.0].define(version: 2022_06_25_033221) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "unit_id", null: false
    t.integer "rejected_by"
    t.datetime "rejected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "approved_at"
    t.integer "approved_by"
    t.string "approved_role"
    t.index ["unit_id", "user_id"], name: "index_access_requests_on_unit_id_and_user_id", unique: true
    t.index ["unit_id"], name: "index_access_requests_on_unit_id"
    t.index ["user_id"], name: "index_access_requests_on_user_id"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "announcements", force: :cascade do |t|
    t.datetime "published_at"
    t.string "announcement_type"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "import_jobs", force: :cascade do |t|
    t.bigint "unit_id", null: false
    t.integer "status"
    t.string "status_text"
    t.integer "row_count"
    t.integer "succeeded_count"
    t.integer "failed_count"
    t.integer "ignored_count"
    t.datetime "started_at"
    t.integer "elapsed_seconds"
    t.string "error_message"
    t.string "logs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_import_jobs_on_unit_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer "meeting_type"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unit_id"
    t.bigint "scheduler_id"
    t.index ["date", "unit_id"], name: "index_meetings_on_date_and_unit_id", unique: true
    t.index ["scheduler_id"], name: "index_meetings_on_scheduler_id"
    t.index ["unit_id"], name: "index_meetings_on_unit_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.integer "gender"
    t.date "birthdate"
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "unit_id"
    t.date "paused_until"
    t.date "paused_on"
    t.integer "paused_by"
    t.date "synced_on"
    t.index ["name", "birthdate"], name: "index_members_on_name_and_birthdate", unique: true
    t.index ["unit_id"], name: "index_members_on_unit_id"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.date "date"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_notes_on_member_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "songs", force: :cascade do |t|
    t.bigint "meeting_id", null: false
    t.string "title"
    t.integer "song_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meeting_id"], name: "index_songs_on_meeting_id"
  end

  create_table "talks", force: :cascade do |t|
    t.string "purpose"
    t.string "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "speaker_name"
    t.bigint "member_id"
    t.bigint "meeting_id"
    t.integer "position"
    t.index ["meeting_id", "position"], name: "unique_meeting_id_position", unique: true
    t.index ["meeting_id"], name: "index_talks_on_meeting_id"
    t.index ["member_id"], name: "index_talks_on_member_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "first_synced_on"
    t.date "last_synced_on"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "announcements_last_read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.bigint "unit_id"
    t.string "phone_number"
    t.boolean "notification_preference_email"
    t.boolean "notification_preference_sms"
    t.integer "role"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unit_id"], name: "index_users_on_unit_id"
  end

  add_foreign_key "access_requests", "units"
  add_foreign_key "access_requests", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "import_jobs", "units"
  add_foreign_key "meetings", "units"
  add_foreign_key "meetings", "users", column: "scheduler_id"
  add_foreign_key "members", "units"
  add_foreign_key "notes", "members"
  add_foreign_key "songs", "meetings"
  add_foreign_key "talks", "meetings"
  add_foreign_key "users", "units"
end
