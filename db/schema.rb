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

ActiveRecord::Schema[8.0].define(version: 2025_07_29_142500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "assignment_answers", force: :cascade do |t|
    t.bigint "assignment_submission_id", null: false
    t.bigint "assignment_question_id", null: false
    t.text "answer_text"
    t.boolean "is_correct", default: false
    t.integer "points_earned", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_question_id"], name: "index_assignment_answers_on_assignment_question_id"
    t.index ["assignment_submission_id", "assignment_question_id"], name: "index_assignment_answers_on_submission_and_question", unique: true
    t.index ["assignment_submission_id"], name: "index_assignment_answers_on_assignment_submission_id"
    t.index ["is_correct"], name: "index_assignment_answers_on_is_correct"
  end

  create_table "assignment_questions", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.text "question_text", null: false
    t.integer "question_type", default: 0, null: false
    t.integer "points", default: 10, null: false
    t.integer "position", null: false
    t.json "options", default: {}
    t.text "correct_answer"
    t.text "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id", "position"], name: "index_assignment_questions_on_assignment_id_and_position"
    t.index ["assignment_id"], name: "index_assignment_questions_on_assignment_id"
    t.index ["question_type"], name: "index_assignment_questions_on_question_type"
  end

  create_table "assignment_submissions", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "user_id", null: false
    t.datetime "submitted_at"
    t.integer "score", default: 0
    t.integer "max_score"
    t.integer "status", default: 0, null: false
    t.text "feedback"
    t.boolean "auto_graded", default: false
    t.datetime "graded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id", "user_id"], name: "index_assignment_submissions_on_assignment_id_and_user_id", unique: true
    t.index ["assignment_id"], name: "index_assignment_submissions_on_assignment_id"
    t.index ["status"], name: "index_assignment_submissions_on_status"
    t.index ["submitted_at"], name: "index_assignment_submissions_on_submitted_at"
    t.index ["user_id"], name: "index_assignment_submissions_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.text "description"
    t.bigint "lesson_id", null: false
    t.integer "assignment_type", default: 0, null: false
    t.integer "max_score", default: 100
    t.datetime "due_date"
    t.text "instructions"
    t.integer "position", default: 1, null: false
    t.boolean "published", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["due_date"], name: "index_assignments_on_due_date"
    t.index ["lesson_id", "position"], name: "index_assignments_on_lesson_id_and_position"
    t.index ["lesson_id"], name: "index_assignments_on_lesson_id"
    t.index ["published"], name: "index_assignments_on_published"
  end

  create_table "content_blocks", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.integer "block_type", null: false
    t.integer "position", null: false
    t.text "content"
    t.string "file_url"
    t.string "alt_text"
    t.json "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_type"], name: "index_content_blocks_on_block_type"
    t.index ["lesson_id", "position"], name: "index_content_blocks_on_lesson_id_and_position"
    t.index ["lesson_id"], name: "index_content_blocks_on_lesson_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "duration"
    t.bigint "instructor_id", null: false
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "enrolled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "lesson_completions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lesson_id"], name: "index_lesson_completions_on_lesson_id"
    t.index ["user_id"], name: "index_lesson_completions_on_user_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "video_url"
    t.bigint "course_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "assignment_answers", "assignment_questions"
  add_foreign_key "assignment_answers", "assignment_submissions"
  add_foreign_key "assignment_questions", "assignments"
  add_foreign_key "assignment_submissions", "assignments"
  add_foreign_key "assignment_submissions", "users"
  add_foreign_key "assignments", "lessons"
  add_foreign_key "content_blocks", "lessons"
  add_foreign_key "courses", "users", column: "instructor_id"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "users"
  add_foreign_key "lesson_completions", "lessons"
  add_foreign_key "lesson_completions", "users"
  add_foreign_key "lessons", "courses"
end
