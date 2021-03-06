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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110811234028) do

  create_table "elaborations", :force => true do |t|
    t.string   "status"
    t.integer  "difficulty"
    t.text     "note_to_self"
    t.text     "note_to_instructor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
  end

  create_table "problem_events", :force => true do |t|
    t.integer  "problem_id"
    t.integer  "step"
    t.string   "name"
    t.text     "value"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", :force => true do |t|
    t.string   "label"
    t.string   "filesPath"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "step_count"
    t.text     "explanations"
  end

  create_table "steps", :force => true do |t|
    t.integer  "index"
    t.text     "justification"
    t.string   "selfcheck"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "understood"
    t.integer  "elaboration_id"
  end

end
