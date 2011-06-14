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

ActiveRecord::Schema.define(:version => 20110614042539) do

  create_table "holiday", :force => true do |t|
    t.date     "holiday_date"
    t.string   "descr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report", :force => true do |t|
    t.date     "date"
    t.string   "description"
    t.integer  "hours"
    t.integer  "task_id"
    t.integer  "user_id"
    t.integer  "workitem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_workitem", :id => false, :force => true do |t|
    t.integer "task_id"
    t.integer "workitem_id"
  end

  create_table "team", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_task", :id => false, :force => true do |t|
    t.integer "task_id", :null => false
    t.integer "team_id", :null => false
  end

  create_table "team_user", :id => false, :force => true do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  create_table "user", :force => true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "crypted_password"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",            :null => false
    t.string   "roles",            :null => false
  end

  create_table "workitem", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "descr"
  end

end
