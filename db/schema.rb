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

ActiveRecord::Schema.define(version: 2022_01_05_070449) do

  create_table "affiliate_discount_mappings", id: false, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "subscription_affiliate_id"
    t.bigint "affiliate_discount_id"
  end

  create_table "affiliate_discounts", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.integer "discount_type"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "app_plans", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "app_id", null: false
    t.bigint "plan_id", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["app_id", "name"], name: "index_app_plans_on_app_id_and_name", unique: true
  end

  create_table "apps", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "secret_key"
    t.string "verification_key"
    t.text "settings"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.string "secondary_secret_key"
    t.string "secondary_verification_key"
    t.index ["name"], name: "index_apps_on_name", unique: true
  end

  create_table "architects", charset: "utf8mb3", force: :cascade do |t|
    t.string "architect_id"
    t.string "architect_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "articles", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "blocked_domains", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "domain", null: false
    t.index ["domain"], name: "index_blocked_domains_on_domain"
  end

  create_table "blocked_number_prefixes", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "prefix", null: false
    t.index ["prefix"], name: "index_blocked_number_prefixes_on_prefix"
  end

  create_table "call_quality_reports", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "time_period"
    t.float "average"
    t.float "median"
    t.float "percentile_25"
    t.float "percentile_75"
    t.float "percentile_95"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.bigint "number_of_calls"
  end

  create_table "calling_card_countries", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "calling_card_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "calling_cards", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.integer "direction", limit: 1, null: false
    t.integer "minutes", limit: 3, null: false
    t.integer "number_type", limit: 1, null: false
    t.integer "rate", limit: 3, null: false
    t.integer "card_type", limit: 1, default: 0
    t.integer "card_status", limit: 1, default: 0
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "countries", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "code", limit: 25, null: false
    t.string "name", limit: 50, null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "deleted_customers", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "status", default: 1
    t.string "admin_name"
    t.string "admin_email"
    t.string "full_domain"
    t.text "account_info"
    t.text "subscription_info"
    t.string "cancel_reason"
    t.text "feedback"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.text "cancel_job_info"
    t.text "delete_job_info"
    t.index ["account_id", "status"], name: "index_deleted_customers_on_account_id_and_status"
  end

  create_table "domain_mappings", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "portal_id"
    t.string "domain", null: false
    t.index ["account_id", "portal_id"], name: "index_domain_mappings_on_account_id_and_portal_id", unique: true
    t.index ["domain"], name: "index_domain_mappings_on_domain", unique: true
  end

  create_table "epics", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "epic_type", null: false
    t.string "architect_id", null: false
    t.string "architect_name", null: false
    t.integer "priority", null: false
    t.integer "bu_unit", null: false
    t.string "i2p_document"
    t.string "assigned_to"
    t.string "manager_name"
    t.integer "quarter"
    t.string "customer_name"
    t.string "created_by"
    t.text "dependent_workflow"
    t.string "impact"
    t.integer "eta"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "theme_id"
    t.string "theme_name"
    t.string "fresh_release_id"
  end

  create_table "failed_central_feeds", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "model_id", null: false
    t.string "uuid"
    t.string "payload_type"
    t.text "model_changes"
    t.text "additional_info"
    t.string "exception"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["account_id"], name: "index_failed_central_feeds_on_account_id"
    t.index ["created_at"], name: "index_failed_central_feeds_on_created_at"
    t.index ["model_id"], name: "index_failed_central_feeds_on_model_id"
    t.index ["uuid"], name: "index_failed_central_feeds_on_uuid"
  end

  create_table "fd_multitenant_organisation_account_mappings", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "organisation_id", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.bigint "bundle_id"
    t.index ["account_id"], name: "index_organisations_on_account_id"
    t.index ["bundle_id"], name: "index_organisations_on_bundle_id"
    t.index ["organisation_id"], name: "index_organisations_on_organisation_id"
  end

  create_table "fd_multitenant_organisations", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.string "domain", null: false
    t.string "name"
    t.string "alternate_domain"
    t.string "region_code"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["domain"], name: "index_organisations_on_domain", unique: true
    t.index ["organisation_id"], name: "index_organisations_on_organisation_id", unique: true
  end

  create_table "feature_flags", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "feature", limit: 100
    t.boolean "enabled", default: false
  end

  create_table "global_configurations", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "key", limit: 100
    t.text "configurations"
  end

  create_table "industries", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.text "config", null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
  end

  create_table "industry_app_mappings", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "industry_id", null: false
    t.integer "app_id"
    t.string "name", null: false
    t.datetime "created_at", precision: 3, null: false
    t.datetime "updated_at", precision: 3, null: false
    t.index ["app_id", "name"], name: "index_industry_app_mappings_on_app_id_and_name"
  end

  create_table "integration_actions", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "integration_id", null: false
    t.string "action_label"
    t.string "t_label"
    t.integer "action_type"
    t.string "action_params"
    t.integer "action_trigger_event"
    t.string "action"
    t.text "config"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.boolean "freshcaller_ui_enabled", default: false
    t.index ["integration_id", "action_trigger_event"], name: "index_on_integration_action_trigger_event"
    t.index ["integration_id", "id"], name: "index_integration_actions_on_integration_id_and_id"
  end

  create_table "integrations", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.text "description"
    t.integer "position"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.text "webhooks"
    t.text "api_endpoints"
    t.string "entity_label"
    t.text "entities_settings"
    t.index ["name"], name: "index_integrations_on_name", unique: true
  end

  create_table "shard_mappings", primary_key: "account_id", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "shard_name", null: false
    t.integer "status", default: 200, null: false
    t.string "pod_name", default: "useast1-pod1", null: false
    t.string "region", default: "us-east-1", null: false
  end

  create_table "signup_failure_reasons", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["name"], name: "index_signup_failure_reasons_on_name"
  end

  create_table "signup_failures", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "email"
    t.string "ip", limit: 100
    t.integer "spam_score"
    t.integer "reason_id"
    t.integer "source_id"
    t.text "other_info"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["email", "reason_id", "source_id"], name: "index_signup_failures_on_email_and_reason_id_and_source_id"
  end

  create_table "signup_sources", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "source_name"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["source_name"], name: "index_signup_sources_on_source_name"
  end

  create_table "subscription_addons", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "price"
    t.integer "renewal_period"
    t.integer "addon_type"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "subscription_affiliates", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.decimal "rate", precision: 6, scale: 4
    t.string "token"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["token"], name: "index_subscription_affiliates_on_token"
  end

  create_table "subscription_currencies", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "currency_name"
    t.decimal "exchange_rate", precision: 10, scale: 5
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "subscription_plan_addons", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "addon_id"
    t.bigint "plan_id"
  end

  create_table "subscription_plans", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.integer "trial_days", null: false
    t.integer "free_quantity", null: false
    t.integer "max_quantity", null: false
    t.text "price", null: false
    t.boolean "classic", default: false, null: false
    t.boolean "free", default: false, null: false
    t.boolean "default", default: false, null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "survey_feedback_details", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "survey_feedback_id", null: false
    t.integer "survey_question_id", null: false
    t.integer "survey_question_option_id"
    t.text "other_info"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "survey_feedbacks", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.integer "deleted_customer_id", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "survey_question_options", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "survey_question_id", null: false
    t.string "option"
    t.boolean "other_option"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "survey_questions", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "survey_id", null: false
    t.boolean "primary"
    t.string "question"
    t.integer "question_type"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "survey_routings", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "survey_question_option_id", null: false
    t.integer "survey_question_id", null: false
    t.boolean "required"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "survey_ticket_group_mappings", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "survey_question_option_id", null: false
    t.integer "ticket_group_id", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "surveys", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "teams", charset: "utf8mb3", force: :cascade do |t|
    t.string "manager_id", null: false
    t.string "manager_name", null: false
    t.integer "team_count", null: false
    t.integer "total_bandwidth"
    t.integer "allocated_bandwidth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "project_id"
    t.string "sub_project_id"
    t.string "owner_id"
    t.string "project_key"
  end

  create_table "themes", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ticket_groups", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "usage_trigger_configs", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "category", null: false
    t.text "value"
    t.text "percentage"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
  end

  create_table "vendor_attachments", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.integer "vendor_id", null: false
    t.string "data_file_name"
    t.string "data_content_type"
    t.string "description"
    t.integer "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["vendor_id"], name: "index_vendor_attachments_on_vendor_id"
  end

  create_table "vendors", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.text "description"
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["name"], name: "index_vendors_on_name", unique: true
  end

  create_table "webhook_events", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "event_name", null: false
    t.boolean "enabled", default: true
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["event_name"], name: "index_webhook_events_on_event_name", unique: true
  end

  create_table "whitelisted_domains", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "domain", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["domain"], name: "index_whitelisted_domains_on_domain", unique: true
  end

  create_table "whitelisted_vendor_clids", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "number", limit: 50, null: false
    t.integer "vendor_id", null: false
    t.datetime "created_at", precision: 3
    t.datetime "updated_at", precision: 3
    t.index ["number"], name: "index_whitelisted_vendor_clids_on_number", unique: true
  end

  create_table "wish_lists", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "wish_list_type", null: false
    t.integer "priority", null: false
    t.string "customer_name"
    t.integer "quarter"
    t.integer "bu_unit", null: false
    t.string "dependent_workflow"
    t.string "impact"
    t.integer "status"
    t.string "created_by"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
