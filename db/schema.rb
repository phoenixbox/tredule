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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130918185058) do

  create_table "doctors", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "mobile"
    t.string   "email"
    t.string   "password_digest"
    t.string   "speciality"
    t.string   "medical_school"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "password_reset_token"
    t.datetime "password_reset_at"
    t.string   "auth_token"
  end

  create_table "doctors_patients", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invites", :force => true do |t|
    t.string   "recipient_email"
    t.integer  "inviteable_id"
    t.string   "inviteable_type"
    t.string   "state"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "recipient_type"
  end

  add_index "invites", ["inviteable_id", "inviteable_type"], :name => "index_invites_on_inviteable_id_and_inviteable_type"

  create_table "patients", :force => true do |t|
    t.string   "first_name"
    t.string   "second_name"
    t.string   "email"
    t.string   "mobile"
    t.string   "dob"
    t.string   "insurance_provider"
    t.string   "policy_number"
    t.string   "medical_card_number"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_at"
  end

end
