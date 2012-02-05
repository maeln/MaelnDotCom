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

ActiveRecord::Schema.define(:version => 20101224125949) do

  create_table "admins", :force => true do |t|
    t.string   "login"
    t.string   "passwd"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "nouvelle_id"
    t.string   "pseudo"
    t.string   "mail"
    t.text     "corp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nouvelles", :force => true do |t|
    t.string   "title"
    t.string   "autor"
    t.string   "tags"
    t.text     "corp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "talkings", :force => true do |t|
    t.string   "pseudo"
    t.text     "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "passwd"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
