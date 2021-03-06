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

ActiveRecord::Schema.define(version: 20170603135913) do

  create_table "autoveicolos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "targa"
    t.string   "modello"
    t.string   "carburante"
    t.float    "kilometri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "media"
    t.index ["user_id"], name: "index_autoveicolos_on_user_id"
  end

  create_table "conversaziones", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "destinatario_id"
    t.string   "messaggio"
    t.boolean  "letto"
    t.boolean  "inviato"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["user_id"], name: "index_conversaziones_on_user_id"
  end

  create_table "notificas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.string   "tipo",           default: "f"
    t.boolean  "read"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["notified_by_id"], name: "index_notificas_on_notified_by_id"
    t.index ["user_id"], name: "index_notificas_on_user_id"
  end

  create_table "officinas", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "indirizzo"
    t.string   "contatto"
    t.string   "numero_telefono"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "cortesia",        default: false
    t.string   "provincia"
    t.index ["user_id"], name: "index_officinas_on_user_id"
  end

  create_table "operazionis", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "km"
    t.date     "data"
    t.string   "oggetto"
    t.string   "officina"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "targa"
    t.float    "costo"
    t.index ["user_id"], name: "index_operazionis_on_user_id"
  end

  create_table "preferitis", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meccanico"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferitis_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "officina_id"
    t.integer  "voto"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["officina_id"], name: "index_ratings_on_officina_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "scadenzes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "tipo"
    t.date     "dataStipulazione"
    t.float    "km"
    t.string   "tipoScadenza"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "notificato",       default: false
    t.string   "targa"
    t.date     "data_scadenza"
    t.index ["user_id"], name: "index_scadenzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "nome"
    t.string   "cognome"
    t.string   "email"
    t.string   "password"
    t.boolean  "tipo"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

end
