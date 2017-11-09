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

ActiveRecord::Schema.define(version: 20170402184624) do

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "assetable_type"
    t.integer  "assetable_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "type",              limit: 100
    t.index ["assetable_type", "assetable_id"], name: "index_attachments_on_assetable_type_and_assetable_id", using: :btree
  end

  create_table "banners", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "date"
    t.text     "description", limit: 65535
    t.string   "type",        limit: 40
    t.boolean  "show",                      default: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "position",                  default: 0
  end

  create_table "careers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "matches_count"
    t.integer  "goals_count"
    t.integer  "player_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["player_id"], name: "index_careers_on_player_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "parent_id"
    t.integer "lft",                                          null: false
    t.integer "rgt",                                          null: false
    t.integer "depth",                        default: 0,     null: false
    t.integer "children_count",               default: 0,     null: false
    t.string  "type",           limit: 40
    t.text    "content",        limit: 65535
    t.boolean "has_nesting",                  default: false
    t.integer "watches_count",                default: 0
    t.integer "template",                     default: 0
    t.index ["lft"], name: "index_categories_on_lft", using: :btree
    t.index ["parent_id"], name: "index_categories_on_parent_id", using: :btree
    t.index ["rgt"], name: "index_categories_on_rgt", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
    t.index ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree
  end

  create_table "commontator_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                                   null: false
    t.text     "body",              limit: 65535,             null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",                 default: 0
    t.integer  "cached_votes_down",               default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
    t.index ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
    t.index ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
    t.index ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree
  end

  create_table "commontator_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "subscriber_type", null: false
    t.integer  "subscriber_id",   null: false
    t.integer  "thread_id",       null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
    t.index ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree
  end

  create_table "commontator_threads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree
  end

  create_table "game_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "timeline_id"
    t.integer  "player_id"
    t.string   "description"
    t.integer  "time"
    t.integer  "event_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["player_id"], name: "index_game_events_on_player_id", using: :btree
    t.index ["timeline_id"], name: "index_game_events_on_timeline_id", using: :btree
  end

  create_table "games", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "round_id"
    t.integer  "home_team_id"
    t.integer  "guest_team_id"
    t.datetime "date"
    t.integer  "home_team_result"
    t.integer  "guest_team_result"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "watches_count",                        default: 0
    t.text     "statistic",         limit: 4294967295
    t.index ["guest_team_id"], name: "index_games_on_guest_team_id", using: :btree
    t.index ["home_team_id"], name: "index_games_on_home_team_id", using: :btree
    t.index ["round_id"], name: "index_games_on_round_id", using: :btree
  end

  create_table "impressions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message",             limit: 65535
    t.text     "referrer",            limit: 65535
    t.text     "params",              limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", length: { ip_address: 100 }, using: :btree
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", length: { request_hash: 100 }, using: :btree
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", length: { session_hash: 100 }, using: :btree
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index", length: { params: 100 }, using: :btree
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", length: { message: 255 }, using: :btree
    t.index ["user_id"], name: "index_impressions_on_user_id", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "short_description", limit: 65535
    t.text     "description",       limit: 65535
    t.integer  "category_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "user_id"
    t.boolean  "is_commentable",                  default: true
    t.datetime "date"
    t.boolean  "is_main",                         default: true
    t.integer  "watches_count",                   default: 0
    t.index ["category_id"], name: "index_news_on_category_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",       limit: 65535
    t.integer  "category_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.integer  "watches_count",                   default: 0
    t.integer  "template",                        default: 0
    t.boolean  "is_commentable",                  default: true
    t.string   "short_description"
    t.index ["category_id"], name: "index_posts_on_category_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "position"
    t.date     "birthday"
    t.string   "place"
    t.integer  "height"
    t.integer  "weight"
    t.text     "description", limit: 65535
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "type",        limit: 40
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "regulations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "regulations_tournaments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "regulation_id"
    t.integer  "tournament_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["regulation_id"], name: "index_regulations_tournaments_on_regulation_id", using: :btree
    t.index ["tournament_id"], name: "index_regulations_tournaments_on_tournament_id", using: :btree
  end

  create_table "results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tournament_id"
    t.integer  "team_structure_id"
    t.integer  "place"
    t.integer  "count_games"
    t.integer  "count_wins"
    t.integer  "count_draws"
    t.integer  "count_losings"
    t.integer  "differences"
    t.integer  "score"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "goals_balls"
    t.integer  "missed_balls"
    t.index ["team_structure_id"], name: "index_results_on_team_structure_id", using: :btree
    t.index ["tournament_id"], name: "index_results_on_tournament_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "rounds", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "tournament_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "statistic",     limit: 4294967295
    t.index ["tournament_id"], name: "index_rounds_on_tournament_id", using: :btree
  end

  create_table "slugs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug"
    t.string   "slugable_type"
    t.integer  "slugable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["slugable_type", "slugable_id"], name: "index_slugs_on_slugable_type_and_slugable_id", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "team_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_structures_on_team_id", using: :btree
  end

  create_table "team_structures_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "team_structure_id"
    t.integer  "player_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["player_id"], name: "index_team_structures_players_on_player_id", using: :btree
    t.index ["team_structure_id"], name: "index_team_structures_players_on_team_structure_id", using: :btree
  end

  create_table "teams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.text     "description",   limit: 65535
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "watches_count",               default: 0
    t.integer  "founded"
    t.string   "location"
    t.string   "trainer"
    t.string   "short_name"
  end

  create_table "timelines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "length"
    t.string   "type"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_timelines_on_game_id", using: :btree
  end

  create_table "tournaments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",       limit: 65535
    t.integer  "category_id"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "is_commentable",                  default: true
    t.boolean  "is_main",                         default: true
    t.text     "short_description", limit: 65535
    t.integer  "watches_count",                   default: 0
    t.index ["category_id"], name: "index_tournaments_on_category_id", using: :btree
  end

  create_table "tournaments_team_structures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tournament_id"
    t.integer  "team_structure_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["team_structure_id"], name: "index_tournaments_team_structures_on_team_structure_id", using: :btree
    t.index ["tournament_id"], name: "index_tournaments_team_structures_on_tournament_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "team_id"
    t.string   "type"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "watches_count",          default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "game_events", "timelines"
  add_foreign_key "game_events", "users", column: "player_id"
  add_foreign_key "news", "categories"
  add_foreign_key "timelines", "games"
  add_foreign_key "tournaments", "categories"
end
