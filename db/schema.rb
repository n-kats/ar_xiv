
ActiveRecord::Schema.define do
  create_table "papers", force: true do |t|
    t.integer  "user_id"
    t.text     "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end

