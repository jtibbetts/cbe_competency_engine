class Lti2TcCollapseData < ActiveRecord::Migration
  def up
    create_table "lti2_tc_deployment_requests", force: true do |t|
      t.string   "reg_key", null: false, limit: 191
      t.string   "reg_password", null: false, limit: 191
      t.text     "tc_oauth_half_secret"
      t.string   "partner_url", limit: 191
      t.string   "status", limit: 191
      t.string   "disposition", limit: 191
      t.string   "confirm_url", limit: 191
      t.string   "tc_profile_guid", limit: 191
      t.text     "tool_proxy_json"
      t.datetime "created_at",           null: false
      t.datetime "updated_at",           null: false
    end

    add_index "lti2_tc_deployment_requests", ["tc_profile_guid"], name: "index_deployment_requests_on_tc_profile_guid", unique: true, using: :btree

    create_table "lti2_tc_links", force: true do |t|
      t.string   "resource_link_label", null: false, limit: 191
      t.boolean  "is_enabled"
      t.integer  "grade_item_id"
      t.integer  "course_id"
      t.integer  "resource_id"
      t.string   "link_parameters"
      t.boolean  "is_name_permission"
      t.boolean  "is_email_permission"
      t.datetime "created_at",          null: false
      t.datetime "updated_at",          null: false
    end

    create_table "lti2_tc_registries", force: true do |t|
      t.string   "name", null: false, limit: 191
      t.text     "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "lti2_tc_resources", force: true do |t|
      t.integer "tool_id"
      t.string  "resource_type", limit: 191
      t.string  "resource_name", limit: 191
      t.string  "description", limit: 191
    end

    create_table "lti2_tc_tool_consumer_profiles", force: true do |t|
      t.string   "tc_profile_guid", limit: 191
      t.text     "tc_profile"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    add_index "lti2_tc_tool_consumer_profiles", ["tc_profile_guid"], name: "index_tool_consumer_profiles_on_tc_profile_guid", unique: true, using: :btree

    create_table "lti2_tc_tool_settings", force: true do |t|
      t.integer "tool_id"
      t.integer "scopeable_id"
      t.string  "scopeable_type", limit: 191
      t.string  "name", limit: 191
      t.string  "value", limit: 191
    end

    create_table "lti2_tc_tools", force: true do |t|
      t.text     "tool_proxy"
      t.boolean  "is_enabled"
      t.string   "product_name", limit: 191
      t.string   "description", limit: 191
      t.string   "key", limit: 191
      t.text     "secret"
      t.string   "status", limit: 191
      t.integer  "new_deployment_request_id"
      t.string   "end_registration_id", limit: 191
      t.string   "registration_return_url", limit: 191
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
    end

    add_index "lti2_tc_tools", ["key"], name: "index_tools_on_key", unique: true, using: :btree
    
  end
  def down
  end
end
