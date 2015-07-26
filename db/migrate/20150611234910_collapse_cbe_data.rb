class CollapseCbeData < ActiveRecord::Migration
  def up
    create_table "cbe_achievement_levels", force: true do |t|
      t.string  "label"
      t.integer "start_of_range"

      t.timestamps
    end

    create_table "cbe_assessments", force: true do |t|
      t.string "title"
      t.text   "description"
      t.string "type"
      t.string "scoring_method"

      t.timestamps
    end

    create_table "cbe_competencies", force: true do |t|
      t.integer "parent_competency_id"
      t.string  "statement"
      t.string  "label",                     default: "", null: false
      t.string  "title",                     default: "", null: false
      t.string  "reference_hierarchy_level"
      t.string  "aggregate",                 default: ""
      t.string  "display"
      t.string  "calculation_method"
      t.integer "sequence_number"

      t.timestamps
    end

    add_index "cbe_competencies", ["parent_competency_id"], name: "parent_competency_id", using: :btree

    create_table "cbe_competency_offering_map", force: true do |t|
      t.integer "course_offering_id", null: false
      t.integer "competency_id",          null: false
      t.integer "sequence_number",        null: false

      t.timestamps
    end

    add_index "cbe_competency_offering_map", ["course_offering_id", "competency_id"], name: "competency_offering_id", unique: true, using: :btree

    create_table "cbe_competency_scores", force: true do |t|
      t.integer "competency_id",                  null: false
      t.integer "course_section_id",              null: false
      t.integer "user_id",                        null: false
      t.string  "label"
      t.float   "final_score",         limit: 24
      t.text    "override_expanation"
      t.float   "computed_score",      limit: 24
      t.date    "completion_date"
      t.date    "start_date"
      t.text    "comment"

      t.timestamps
    end

    add_index "cbe_competency_scores", ["competency_id", "user_id", "course_section_id"], name: "competency_id", unique: true, using: :btree

    create_table "cbe_course_section_members", force: true do |t|
      t.integer "course_section_id", null: false
      t.integer "user_id", null: false
      t.string  "role"

      t.timestamps
    end

    create_table "cbe_course_offerings", force: true do |t|
      t.integer "program_id", null: false
      t.string  "label",       default: "", null: false
      t.string  "title"
      t.string  "version"

      t.timestamps
    end

    create_table "cbe_course_sections", force: true do |t|
      t.integer  "course_offering_id", null: false
      t.integer  "term_id",    null: false
      t.string   "label"
      t.string   "title"
      t.string   "section_number"

      t.timestamps
    end

    create_table "cbe_criteria", force: true do |t|
      t.integer "competency_id"
      t.integer "rubric_id",                                null: false
      t.string  "criterion",                   default: "", null: false
      t.float   "weight",           limit: 24,              null: false
      t.text    "criterion_text"
      t.integer "criterion_weight"

      t.timestamps
    end

    create_table "cbe_criterion_scores", force: true do |t|
      t.integer   "competency_id"
      t.integer   "user_id"
      t.integer   "course_section_id"
      t.integer   "criterion_id"
      t.integer   "attempt"
      t.string    "faculty_judgement"
      t.integer   "numeric_score"
      t.text      "feedback"
      t.timestamp "timestamp"
      t.integer   "faculty_id"

      t.timestamps
    end

    create_table "cbe_organizations", force: true do |t|
      t.string "legal_name"
      t.string "label"
      t.text   "description"
      t.string "website"

      t.timestamps
    end

    create_table "cbe_programs", force: true do |t|
      t.string "label"
      t.string "degree_level", default: "", null: false
      t.string "version"

      t.timestamps
    end

    create_table "cbe_rubric", force: true do |t|
      t.integer "criterion_id"
      t.integer "assessment_id",                 null: false
      t.integer "criterion_position"
      t.float   "criterion_weight",   limit: 24

      t.timestamps
    end

    add_index "cbe_rubric", ["assessment_id"], name: "competency_id", using: :btree

    create_table "cbe_terms", force: true do |t|
      t.date "start_date",  null: false
      t.date "end_date",    null: false
      t.text "description"

      t.timestamps
    end

    create_table "cbe_users", force: true do |t|
      t.string  "givenName",  default: "", null: false
      t.string  "familyName", default: "", null: false
      t.string  "name",   default: "", null: false
      t.string  "email",                  default: "", null: false
      t.integer "external_id"

      t.timestamps
    end

    create_table "cbe_workproducts", force: true do |t|
      t.integer "user_id",           null: false
      t.integer "assessment_id"
      t.integer "course_section_id"
      t.integer "attempt"
      t.string  "workproduct_url"
      t.string  "grade"
      t.text    "overall_feedback"
      t.integer "faculty_it"

      t.timestamps
    end

    add_index "cbe_workproducts", ["user_id"], name: "competency_score_id", using: :btree
  end

  def down
    drop_table :cbe_assessments
    drop_table :cbe_competencies
    drop_table :cbe_competency_offering_map
    drop_table :cbe_competency_scores
    drop_table :cbe_course_offerings
    drop_table :cbe_course_sections
    drop_table :cbe_criteria
    drop_table :cbe_criterion_scores
    drop_table :cbe_organizations
    drop_table :cbe_programs
    drop_table :cbe_rubric
    drop_table :cbe_terms
    drop_table :cbe_users
    drop_table :cbe_workproducts
  end

end
