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

ActiveRecord::Schema.define(version: 20150611234910) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "role"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mentor"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "cbe_achievement_levels", force: true do |t|
    t.string   "label"
    t.integer  "start_of_range"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_assessments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "type"
    t.string   "scoring_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_competencies", force: true do |t|
    t.integer  "parent_competency_id"
    t.string   "statement"
    t.string   "label",                     default: "", null: false
    t.string   "title",                     default: "", null: false
    t.string   "reference_hierarchy_level"
    t.string   "aggregate",                 default: ""
    t.string   "display"
    t.string   "calculation_method"
    t.integer  "sequence_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbe_competencies", ["parent_competency_id"], name: "parent_competency_id", using: :btree

  create_table "cbe_competency_offering_map", force: true do |t|
    t.integer  "course_offering_id", null: false
    t.integer  "competency_id",      null: false
    t.integer  "sequence_number",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbe_competency_offering_map", ["course_offering_id", "competency_id"], name: "competency_offering_id", unique: true, using: :btree

  create_table "cbe_competency_scores", force: true do |t|
    t.integer  "competency_id",                  null: false
    t.integer  "course_section_id",              null: false
    t.integer  "user_id",                        null: false
    t.string   "label"
    t.float    "final_score",         limit: 24
    t.text     "override_expanation"
    t.float    "computed_score",      limit: 24
    t.date     "completion_date"
    t.date     "start_date"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbe_competency_scores", ["competency_id", "user_id", "course_section_id"], name: "competency_id", unique: true, using: :btree

  create_table "cbe_course_offerings", force: true do |t|
    t.integer  "program_id",              null: false
    t.string   "label",      default: "", null: false
    t.string   "title"
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_course_section_members", force: true do |t|
    t.integer  "course_section_id", null: false
    t.integer  "user_id",           null: false
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_course_sections", force: true do |t|
    t.integer  "course_offering_id", null: false
    t.integer  "term_id",            null: false
    t.string   "label"
    t.string   "title"
    t.string   "section_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_criteria", force: true do |t|
    t.integer  "competency_id"
    t.integer  "rubric_id",                                null: false
    t.string   "criterion",                   default: "", null: false
    t.float    "weight",           limit: 24,              null: false
    t.text     "criterion_text"
    t.integer  "criterion_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_criterion_scores", force: true do |t|
    t.integer  "competency_id"
    t.integer  "user_id"
    t.integer  "course_section_id"
    t.integer  "criterion_id"
    t.integer  "attempt"
    t.string   "faculty_judgement"
    t.integer  "numeric_score"
    t.text     "feedback"
    t.datetime "timestamp"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_organizations", force: true do |t|
    t.string   "legal_name"
    t.string   "label"
    t.text     "description"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_programs", force: true do |t|
    t.string   "label"
    t.string   "degree_level", default: "", null: false
    t.string   "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_rubric", force: true do |t|
    t.integer  "criterion_id"
    t.integer  "assessment_id",                 null: false
    t.integer  "criterion_position"
    t.float    "criterion_weight",   limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbe_rubric", ["assessment_id"], name: "competency_id", using: :btree

  create_table "cbe_terms", force: true do |t|
    t.date     "start_date",  null: false
    t.date     "end_date",    null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_users", force: true do |t|
    t.string   "givenName",   default: "", null: false
    t.string   "familyName",  default: "", null: false
    t.string   "name",        default: "", null: false
    t.string   "email",       default: "", null: false
    t.integer  "external_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cbe_workproducts", force: true do |t|
    t.integer  "user_id",           null: false
    t.integer  "assessment_id"
    t.integer  "course_section_id"
    t.integer  "attempt"
    t.string   "workproduct_url"
    t.string   "grade"
    t.text     "overall_feedback"
    t.integer  "faculty_it"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cbe_workproducts", ["user_id"], name: "competency_score_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "course_label"
    t.string   "course_title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "enrollments", force: true do |t|
    t.integer  "admin_user_id"
    t.integer  "course_id"
    t.string   "role"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "grade_items", force: true do |t|
    t.integer  "course_id"
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grade_results", force: true do |t|
    t.integer  "link_id"
    t.integer  "admin_user_id"
    t.float    "result",        limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "lti2_tc_deployment_requests", force: true do |t|
    t.string   "reg_key",              limit: 191, null: false
    t.string   "reg_password",         limit: 191, null: false
    t.text     "tc_oauth_half_secret"
    t.string   "partner_url",          limit: 191
    t.string   "status",               limit: 191
    t.string   "disposition",          limit: 191
    t.string   "confirm_url",          limit: 191
    t.string   "tc_profile_guid",      limit: 191
    t.text     "tool_proxy_json"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "lti2_tc_deployment_requests", ["tc_profile_guid"], name: "index_deployment_requests_on_tc_profile_guid", unique: true, using: :btree

  create_table "lti2_tc_links", force: true do |t|
    t.string   "resource_link_label", limit: 191, null: false
    t.boolean  "is_enabled"
    t.integer  "grade_item_id"
    t.integer  "course_id"
    t.integer  "resource_id"
    t.string   "link_parameters"
    t.boolean  "is_name_permission"
    t.boolean  "is_email_permission"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "lti2_tc_registries", force: true do |t|
    t.string   "name",       limit: 191, null: false
    t.text     "content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lti2_tc_resources", force: true do |t|
    t.integer "tool_id"
    t.string  "resource_type", limit: 191
    t.string  "resource_name", limit: 191
    t.string  "description",   limit: 191
  end

  create_table "lti2_tc_tool_consumer_profiles", force: true do |t|
    t.string   "tc_profile_guid", limit: 191
    t.text     "tc_profile"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "lti2_tc_tool_consumer_profiles", ["tc_profile_guid"], name: "index_tool_consumer_profiles_on_tc_profile_guid", unique: true, using: :btree

  create_table "lti2_tc_tool_settings", force: true do |t|
    t.integer "tool_id"
    t.integer "scopeable_id"
    t.string  "scopeable_type", limit: 191
    t.string  "name",           limit: 191
    t.string  "value",          limit: 191
  end

  create_table "lti2_tc_tools", force: true do |t|
    t.text     "tool_proxy"
    t.boolean  "is_enabled"
    t.string   "product_name",              limit: 191
    t.string   "description",               limit: 191
    t.string   "key",                       limit: 191
    t.text     "secret"
    t.string   "status",                    limit: 191
    t.integer  "new_deployment_request_id"
    t.string   "end_registration_id",       limit: 191
    t.string   "registration_return_url",   limit: 191
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "lti2_tc_tools", ["key"], name: "index_tools_on_key", unique: true, using: :btree

end
