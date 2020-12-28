# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_28_093313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "doctor_degrees", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_doctor_degrees_on_code"
  end

  create_table "doctors", force: :cascade do |t|
    t.bigint "user_id"
    t.string "fdd_id"
    t.string "name"
    t.string "slug"
    t.string "title"
    t.string "email"
    t.string "practice_name"
    t.string "phone"
    t.string "fax"
    t.string "website_url"
    t.string "primary_speciality"
    t.integer "min_price", default: 0
    t.integer "max_price", default: 0
    t.text "prices", default: ""
    t.string "style"
    t.string "access"
    t.jsonb "additional_features", default: {}
    t.string "consultation"
    t.text "address_line_1"
    t.integer "zipcode"
    t.string "city"
    t.string "state"
    t.jsonb "social_profiles", default: {}
    t.jsonb "education", default: {}
    t.jsonb "certifications", default: {}
    t.jsonb "achievements", default: {}
    t.jsonb "background_info", default: {}
    t.integer "fmdd_score", default: 0
    t.integer "pear_recomendations", array: true
    t.text "image_data"
    t.string "status", default: "draft"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "patients_in_panel", default: ""
    t.integer "min_patients"
    t.integer "max_patients"
    t.string "free_consultation_time"
    t.string "is_holistic_medicine"
    t.string "holistic_option"
    t.string "is_telehealth_service"
    t.string "telehealth_option"
    t.string "is_home_visit"
    t.string "home_visit_option"
    t.string "aditional_services"
    t.string "appointments"
    t.string "language"
    t.integer "min_experience", default: 0
    t.integer "max_experience", default: 0
    t.string "gender"
    t.string "other_specialities", array: true
    t.text "about_doctor"
    t.text "about_clinic"
    t.string "active_licenses", array: true
    t.text "disciplinary_action_taken"
    t.decimal "lat"
    t.decimal "lng"
    t.text "disciplinary_action_details"
    t.string "address_suite"
    t.jsonb "alternate_emails", default: {}
    t.jsonb "alternate_phones", default: {}
    t.string "old_fdd_id"
    t.string "contact_us_url"
    t.integer "speciality_id"
    t.decimal "avg_rating", precision: 6, scale: 1
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.integer "specialities", array: true
    t.string "name"
    t.string "board_certification"
    t.string "hours"
    t.string "experience"
    t.integer "salary"
    t.integer "sign_on_bonus"
    t.string "paid_time_off"
    t.string "loan_assistance"
    t.string "health_insurence"
    t.string "medical_insurence"
    t.string "visa_sponsorship"
    t.text "resume_data"
    t.jsonb "degree", default: {}
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_jobs_on_doctor_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "state_id", null: false
    t.string "name"
    t.string "county"
    t.string "state_code"
    t.string "state"
    t.string "zip_codes"
    t.string "location_type"
    t.string "latitude"
    t.string "longitude"
    t.string "area_code"
    t.string "population"
    t.string "households"
    t.string "median_income"
    t.string "land_area"
    t.string "water_area"
    t.string "time_zone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_locations_on_state_id"
  end

  create_table "media_storages", force: :cascade do |t|
    t.text "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "page_redirects", force: :cascade do |t|
    t.string "old"
    t.string "new"
    t.integer "redirect_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "comments"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_page_redirects_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.string "name"
    t.string "email"
    t.integer "rating"
    t.string "title"
    t.text "review"
    t.string "treated_by_doctor"
    t.string "will_you_recommend"
    t.string "anonymous"
    t.string "status", default: "draft"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_reviews_on_doctor_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_specialities_on_code"
  end

  create_table "speciality_aliases", force: :cascade do |t|
    t.bigint "speciality_id", null: false
    t.string "speciality_code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["speciality_code"], name: "index_speciality_aliases_on_speciality_code"
    t.index ["speciality_id"], name: "index_speciality_aliases_on_speciality_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "status", default: "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.string "email"
    t.text "survey"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tips", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "code"
    t.text "summary"
    t.text "content"
    t.integer "author_id"
    t.string "meta_title"
    t.jsonb "meta_keywords"
    t.text "meta_description"
    t.string "h1_tag"
    t.text "image_data"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "related_topics", array: true
    t.bigint "topic_id"
    t.index ["code"], name: "index_tips_on_code", unique: true
    t.index ["slug"], name: "index_tips_on_slug", unique: true
    t.index ["topic_id"], name: "index_tips_on_topic_id"
  end

  create_table "topic_tips", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "tip_id", null: false
    t.integer "position", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tip_id"], name: "index_topic_tips_on_tip_id"
    t.index ["topic_id"], name: "index_topic_tips_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "summary"
    t.text "content"
    t.boolean "is_popular", default: false
    t.integer "author_id"
    t.string "meta_title"
    t.text "meta_description"
    t.string "h1_tag"
    t.text "image_data"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "meta_keywords"
    t.bigint "category_id"
    t.integer "read_time"
    t.string "primary_keyword"
    t.index ["category_id"], name: "index_topics_on_category_id"
    t.index ["primary_keyword"], name: "index_topics_on_primary_keyword", unique: true
    t.index ["slug"], name: "index_topics_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "full_name", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: ""
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "image_data"
    t.text "about"
    t.string "title"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "doctors", "users"
  add_foreign_key "jobs", "doctors"
  add_foreign_key "locations", "states"
  add_foreign_key "reviews", "doctors"
  add_foreign_key "speciality_aliases", "specialities"
  add_foreign_key "taggings", "tags"
  add_foreign_key "topic_tips", "tips"
  add_foreign_key "topic_tips", "topics"

  create_view "review_datas", materialized: true, sql_definition: <<-SQL
      SELECT reviews.doctor_id,
      count(*) AS total,
      avg(reviews.rating) AS avg_rating
     FROM reviews
    WHERE ((reviews.status)::text = 'published'::text)
    GROUP BY reviews.doctor_id;
  SQL
end
