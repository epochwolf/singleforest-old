# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100221061633) do

  create_table "audits", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.string   "object_type"
    t.integer  "object_id"
    t.string   "action"
    t.text     "changeset"
    t.text     "note",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audits", ["user_id"], :name => "index_audits_on_user_id"

  create_table "collections", :force => true do |t|
    t.string   "title",                                :null => false
    t.text     "description"
    t.integer  "user_id",                              :null => false
    t.boolean  "series",            :default => false, :null => false
    t.integer  "literatures_count", :default => 0,     :null => false
    t.integer  "scratchpads_count", :default => 0,     :null => false
    t.boolean  "soft_delete",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collections", ["title", "user_id"], :name => "index_collections_on_title_and_user_id", :unique => true

  create_table "comment_threads", :force => true do |t|
    t.integer  "commentable_id",                      :null => false
    t.string   "commentable_type",                    :null => false
    t.boolean  "lock",             :default => false, :null => false
    t.boolean  "admin_only",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_threads", ["commentable_type", "commentable_id"], :name => "index_comment_threads_on_commentable_type_and_commentable_id", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "comment_thread_id",                    :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.text     "contents",                             :null => false
    t.integer  "user_id",                              :null => false
    t.boolean  "soft_delete",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["comment_thread_id"], :name => "index_comments_on_comment_thread_id"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["rgt", "lft"], :name => "index_comments_on_rgt_and_lft"

  create_table "flags", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.text     "message"
    t.string   "flaggable_type", :null => false
    t.integer  "flaggable_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_categories", :force => true do |t|
    t.string   "title",                          :null => false
    t.text     "summary"
    t.text     "description"
    t.integer  "forum_id",                       :null => false
    t.boolean  "admin_only",  :default => false, :null => false
    t.boolean  "news",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forum_threads", :force => true do |t|
    t.string   "title",                                :null => false
    t.text     "content",                              :null => false
    t.integer  "forum_category_id"
    t.integer  "user_id",                              :null => false
    t.boolean  "admin_only",        :default => false, :null => false
    t.boolean  "sink",              :default => false, :null => false
    t.boolean  "soft_delete",       :default => false, :null => false
    t.datetime "bumped_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forum_threads", ["bumped_at"], :name => "index_forum_threads_on_bumped_at"
  add_index "forum_threads", ["forum_category_id"], :name => "index_forum_threads_on_forum_category_id"

  create_table "forums", :force => true do |t|
    t.string   "title",                         :null => false
    t.boolean  "admin_only", :default => false, :null => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "literature_votes", :force => true do |t|
    t.integer  "user_id",                      :null => false
    t.integer  "literature_id",                :null => false
    t.integer  "vote",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "literature_votes", ["user_id", "literature_id"], :name => "index_literature_votes_on_user_id_and_literature_id", :unique => true

  create_table "literatures", :force => true do |t|
    t.string   "title",                                 :null => false
    t.integer  "user_id",                               :null => false
    t.integer  "word_count"
    t.text     "artists_note"
    t.text     "note_to_commenters"
    t.text     "contents",                              :null => false
    t.text     "summary"
    t.integer  "collection_id"
    t.integer  "collection_order"
    t.boolean  "mature",             :default => false, :null => false
    t.boolean  "mature_sex",         :default => false, :null => false
    t.boolean  "mature_violence",    :default => false, :null => false
    t.boolean  "draft",              :default => true,  :null => false
    t.boolean  "critique",           :default => false, :null => false
    t.boolean  "hide",               :default => false, :null => false
    t.boolean  "soft_delete",        :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "literatures", ["created_at"], :name => "index_literatures_on_created_at"
  add_index "literatures", ["user_id"], :name => "index_literatures_on_user_id"

  create_table "literatures_tags", :id => false, :force => true do |t|
    t.integer "literature_id"
    t.integer "tag_id"
  end

  add_index "literatures_tags", ["literature_id", "tag_id"], :name => "index_literatures_tags_on_literature_id_and_tag_id"

  create_table "notes", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "title"
    t.text     "contents"
    t.boolean  "read",        :default => false
    t.boolean  "flagged",     :default => false
    t.boolean  "soft_delete", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.string   "object_type"
    t.integer  "object_id"
    t.string   "action"
    t.integer  "object_owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title",                         :null => false
    t.string   "title_slug",                    :null => false
    t.text     "contents",   :default => "",    :null => false
    t.boolean  "lock",       :default => false, :null => false
    t.boolean  "hide",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["title_slug"], :name => "index_pages_on_title_slug"

  create_table "scratchpads", :force => true do |t|
    t.string   "title",                               :null => false
    t.text     "contents",                            :null => false
    t.integer  "collection_id"
    t.integer  "collection_order"
    t.integer  "user_id",                             :null => false
    t.boolean  "soft_delete",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scratchpads", ["user_id"], :name => "index_scratchpads_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "openid_url",                         :null => false
    t.integer  "rank",            :default => 0,     :null => false
    t.boolean  "confirmed",       :default => false, :null => false
    t.boolean  "closed",          :default => false, :null => false
    t.boolean  "banned",          :default => false, :null => false
    t.string   "website"
    t.text     "biography"
    t.string   "api_key"
    t.date     "last_visited_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], :name => "index_users_on_name"

  create_table "watches", :force => true do |t|
    t.integer  "watcher_id",                    :null => false
    t.integer  "watchee_id",                    :null => false
    t.boolean  "public",      :default => true, :null => false
    t.boolean  "collections", :default => true, :null => false
    t.boolean  "literature",  :default => true, :null => false
    t.boolean  "scratchpads", :default => true, :null => false
    t.boolean  "other",       :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
