# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170724113346) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artwork_collaborators", force: :cascade do |t|
    t.integer  "artwork_id"
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "artwork_collaborators", ["artwork_id"], name: "index_artwork_collaborators_on_artwork_id", using: :btree
  add_index "artwork_collaborators", ["user_id"], name: "index_artwork_collaborators_on_user_id", using: :btree

  create_table "artworks", force: :cascade do |t|
    t.string  "image_url"
    t.string  "title"
    t.integer "height"
    t.integer "width"
    t.integer "length"
    t.integer "unit"
    t.integer "year"
    t.string  "art_type"
    t.string  "description"
    t.integer "user_id"
    t.integer "series_id"
    t.boolean "for_sale",           default: false
    t.string  "country"
    t.string  "city"
    t.text    "notes"
    t.integer "artist_inventory"
    t.integer "gallery_inventory"
    t.text    "private_collection"
    t.text    "public_collection"
    t.integer "edition"
    t.integer "edition_of"
    t.string  "signature"
    t.string  "signature_location"
    t.boolean "signed_dated",       default: false
    t.boolean "acknowledgement",    default: false
    t.integer "position"
    t.integer "medium_ids",         default: [],    array: true
    t.integer "subject_ids",        default: [],    array: true
    t.integer "month"
  end

  add_index "artworks", ["medium_ids"], name: "index_artworks_on_medium_ids", using: :gin
  add_index "artworks", ["series_id"], name: "index_artworks_on_series_id", using: :btree
  add_index "artworks", ["subject_ids"], name: "index_artworks_on_subject_ids", using: :gin

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "awards", force: :cascade do |t|
    t.string  "title",         null: false
    t.string  "awarding_body"
    t.string  "prize"
    t.integer "user_id"
    t.integer "month"
    t.integer "year"
    t.string  "country"
    t.string  "state"
    t.string  "location"
  end

  add_index "awards", ["user_id"], name: "index_awards_on_user_id", using: :btree

  create_table "bibliographies", force: :cascade do |t|
    t.string  "title",               null: false
    t.string  "publication_title"
    t.string  "publisher"
    t.string  "edition"
    t.string  "author"
    t.string  "page_number"
    t.integer "source_type"
    t.string  "link"
    t.integer "user_id"
    t.string  "participation"
    t.string  "publication_city"
    t.string  "publication_country"
    t.string  "editor"
    t.string  "issue"
    t.string  "pdf_url"
    t.integer "month"
    t.integer "year"
    t.string  "attachment_url"
    t.string  "location"
    t.string  "pdf_filename"
  end

  add_index "bibliographies", ["user_id"], name: "index_bibliographies_on_user_id", using: :btree

  create_table "collections", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string  "name"
    t.string  "motto"
    t.string  "location"
    t.date    "established_in"
    t.string  "address_1"
    t.string  "contact"
    t.string  "about_us"
    t.string  "facebook"
    t.string  "twitter"
    t.string  "instagram"
    t.integer "owner_id"
    t.integer "organization_type_ids", default: [], array: true
    t.text    "description"
    t.string  "country"
    t.string  "state"
    t.string  "phone"
    t.string  "email"
    t.integer "position"
    t.string  "website"
    t.time    "opening_time"
    t.time    "closing_time"
    t.string  "address_2"
    t.string  "image_url"
    t.string  "postcode"
  end

  add_index "companies", ["organization_type_ids"], name: "index_companies_on_organization_type_ids", using: :gin

  create_table "company_memberships", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.integer  "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "company_memberships", ["company_id"], name: "index_company_memberships_on_company_id", using: :btree
  add_index "company_memberships", ["user_id"], name: "index_company_memberships_on_user_id", using: :btree

  create_table "connections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "status"
  end

  create_table "educations", force: :cascade do |t|
    t.string   "name"
    t.boolean  "done"
    t.integer  "user_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "institution"
    t.string   "education_level"
    t.string   "education_grade"
    t.string   "field_of_study"
    t.string   "education_description"
    t.integer  "start_month"
    t.integer  "end_month"
    t.integer  "start_year"
    t.integer  "end_year"
    t.string   "state"
    t.string   "country"
    t.string   "location"
    t.string   "other_institution"
  end

  add_index "educations", ["user_id"], name: "index_educations_on_user_id", using: :btree

  create_table "event_notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_participation_id"
    t.integer  "status"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "event_participations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "involvement"
    t.integer  "event_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "added_to_profile", default: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.string   "event_type"
    t.string   "type_other"
    t.string   "type_exhibition"
    t.string   "cover_image_url"
    t.string   "location"
    t.string   "city"
    t.string   "country"
    t.text     "description"
    t.string   "website_link"
    t.string   "facebook_link"
    t.string   "instagram_link"
    t.string   "twitter_link"
    t.integer  "company_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.date     "start_date"
    t.date     "end_date"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "postcode"
  end

  add_index "events", ["company_id"], name: "index_events_on_company_id", using: :btree

  create_table "exhibitions", force: :cascade do |t|
    t.string   "title"
    t.string   "venue"
    t.string   "state"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "involvement"
    t.string   "pdf_url"
    t.string   "representation"
    t.string   "link"
    t.integer  "venue_id"
    t.integer  "representation_id"
    t.integer  "start_year"
    t.integer  "end_year"
    t.integer  "start_month"
    t.integer  "end_month"
    t.integer  "record_start_year"
    t.integer  "record_end_year"
    t.string   "location"
    t.string   "pdf_filename"
    t.integer  "category"
    t.string   "involvement_string"
  end

  add_index "exhibitions", ["representation_id"], name: "index_exhibitions_on_representation_id", using: :btree
  add_index "exhibitions", ["user_id"], name: "index_exhibitions_on_user_id", using: :btree
  add_index "exhibitions", ["venue_id"], name: "index_exhibitions_on_venue_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.string  "position"
    t.string  "state"
    t.string  "country"
    t.string  "link"
    t.integer "user_id"
    t.integer "category"
    t.integer "job_type"
    t.integer "company_id"
    t.text    "description"
    t.integer "start_month"
    t.integer "start_year"
    t.integer "end_month"
    t.integer "end_year"
    t.boolean "current",     default: false
    t.string  "location"
  end

  add_index "experiences", ["company_id"], name: "index_experiences_on_company_id", using: :btree

  create_table "feed_items", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "artwork_id"
    t.integer  "kind",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "resource_type"
    t.integer  "resource_id"
  end

  add_index "feed_items", ["artwork_id"], name: "index_feed_items_on_artwork_id", using: :btree
  add_index "feed_items", ["user_id"], name: "index_feed_items_on_user_id", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "state",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "interests", ["user_id"], name: "index_interests_on_user_id", using: :btree

  create_table "language_proficiencies", force: :cascade do |t|
    t.integer "language_id", null: false
    t.integer "profile_id",  null: false
    t.integer "level"
  end

  add_index "language_proficiencies", ["language_id"], name: "index_language_proficiencies_on_language_id", using: :btree
  add_index "language_proficiencies", ["profile_id"], name: "index_language_proficiencies_on_profile_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "state",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "languages", ["user_id"], name: "index_languages_on_user_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "state",               default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.date     "action_date"
    t.date     "name_edit_date"
    t.integer  "user_with_same_tags", default: [],                 array: true
    t.boolean  "set_display",         default: false
  end

  create_table "media_features", force: :cascade do |t|
    t.string  "title"
    t.string  "link"
    t.integer "user_id"
    t.text    "description"
    t.integer "month"
    t.integer "year"
  end

  create_table "memberships", force: :cascade do |t|
    t.string  "name"
    t.date    "year"
    t.integer "user_id"
    t.date    "start_date"
    t.date    "end_date"
    t.integer "company_id"
  end

  create_table "opening_times", force: :cascade do |t|
    t.integer  "weekday"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_types", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "state",         default: 0
    t.boolean  "public_option", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "organization_types", ["user_id"], name: "index_organization_types_on_user_id", using: :btree

  create_table "participations", force: :cascade do |t|
    t.string  "description"
    t.string  "link"
    t.integer "user_id"
    t.string  "title"
    t.integer "month"
    t.integer "year"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "medium_ids",         default: [],              array: true
    t.integer  "subject_ids",        default: [],              array: true
    t.integer  "specialisation_ids", default: [],              array: true
    t.integer  "interest_ids",       default: [],              array: true
    t.integer  "skill_ids",          default: [],              array: true
    t.integer  "service_ids",        default: [],              array: true
    t.string   "role"
  end

  add_index "profiles", ["interest_ids"], name: "index_profiles_on_interest_ids", using: :gin
  add_index "profiles", ["medium_ids"], name: "index_profiles_on_medium_ids", using: :gin
  add_index "profiles", ["service_ids"], name: "index_profiles_on_service_ids", using: :gin
  add_index "profiles", ["skill_ids"], name: "index_profiles_on_skill_ids", using: :gin
  add_index "profiles", ["specialisation_ids"], name: "index_profiles_on_specialisation_ids", using: :gin
  add_index "profiles", ["subject_ids"], name: "index_profiles_on_subject_ids", using: :gin
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "publications", force: :cascade do |t|
    t.string  "participation"
    t.string  "title"
    t.string  "publication_title"
    t.string  "country"
    t.string  "state"
    t.string  "publisher"
    t.string  "edition"
    t.string  "editor"
    t.string  "issue"
    t.string  "page_numbers"
    t.string  "link"
    t.integer "user_id"
    t.string  "pdf_url"
    t.string  "attachment_url"
    t.integer "category"
    t.integer "year"
    t.integer "month"
    t.integer "day"
    t.string  "location"
    t.string  "pdf_filename"
  end

  create_table "residencies", force: :cascade do |t|
    t.string  "body"
    t.string  "title"
    t.string  "country"
    t.string  "state"
    t.integer "user_id"
    t.integer "start_month"
    t.integer "start_year"
    t.integer "end_month"
    t.integer "end_year"
    t.boolean "current",     default: false
    t.string  "location"
  end

  create_table "series", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "artwork_id"
    t.integer  "exhibition_id"
    t.string   "title"
    t.text     "description"
    t.date     "year"
    t.boolean  "acknowledgement", default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "link"
    t.integer  "status",          default: 0,     null: false
  end

  add_index "series", ["artwork_id"], name: "index_series_on_artwork_id", using: :btree
  add_index "series", ["exhibition_id"], name: "index_series_on_exhibition_id", using: :btree
  add_index "series", ["user_id"], name: "index_series_on_user_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "state",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "state",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "skills", ["user_id"], name: "index_skills_on_user_id", using: :btree

  create_table "specialisations", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "state",               default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.date     "action_date"
    t.date     "name_edit_date"
    t.integer  "user_with_same_tags", default: [],              array: true
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "state",               default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.date     "action_date"
    t.date     "name_edit_date"
    t.integer  "user_with_same_tags", default: [],                 array: true
    t.boolean  "set_display",         default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                           null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "title"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "role"
    t.boolean  "active",                          default: true
    t.string   "reason_deactivating"
    t.string   "nationality_country"
    t.integer  "residency_status"
    t.string   "based_country"
    t.string   "current_status"
    t.string   "exhibit_title"
    t.string   "participation"
    t.string   "venue"
    t.string   "exhibit_country"
    t.string   "exhibit_state"
    t.string   "link"
    t.string   "acknowledgement"
    t.integer  "company_id"
    t.string   "tagline"
    t.string   "statement"
    t.string   "skill"
    t.string   "interest"
    t.string   "language"
    t.integer  "language_level"
    t.string   "facebook_link"
    t.string   "twitter_link"
    t.string   "instagram_link"
    t.date     "from_exhibit_date"
    t.date     "to_exhibit_date"
    t.string   "representation"
    t.string   "position"
    t.string   "company_name"
    t.string   "exhibit_description"
    t.date     "from_record_year"
    t.date     "to_record_year"
    t.text     "specialisations_tags",            default: [],                 array: true
    t.text     "media_tags",                      default: [],                 array: true
    t.text     "subjects_tags",                   default: [],                 array: true
    t.text     "skills",                          default: [],                 array: true
    t.integer  "grade"
    t.string   "gallery_museum"
    t.integer  "gender"
    t.integer  "membership_id"
    t.text     "artist_status_text",              default: [],                 array: true
    t.text     "professional_status_text",        default: [],                 array: true
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "based_state"
    t.string   "other_status"
    t.boolean  "commission"
    t.integer  "referrer_id"
    t.integer  "referrals_count",                 default: 0
    t.string   "profile_image_url"
    t.string   "based_location"
    t.boolean  "email_confirmed",                 default: false
    t.string   "confirmation_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["media_tags"], name: "index_users_on_media_tags", using: :gin
  add_index "users", ["referrer_id"], name: "index_users_on_referrer_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["skills"], name: "index_users_on_skills", using: :gin
  add_index "users", ["specialisations_tags"], name: "index_users_on_specialisations_tags", using: :gin
  add_index "users", ["subjects_tags"], name: "index_users_on_subjects_tags", using: :gin

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "awards", "users"
  add_foreign_key "bibliographies", "users"
  add_foreign_key "educations", "users"
  add_foreign_key "feed_items", "artworks"
  add_foreign_key "feed_items", "users"
  add_foreign_key "language_proficiencies", "languages"
  add_foreign_key "language_proficiencies", "profiles"
end
