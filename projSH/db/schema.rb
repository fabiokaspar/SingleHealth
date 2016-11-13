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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultations", primary_key: ["id", "loginsh_pac", "loginsh_med"], force: :cascade do |t|
    t.date    "dt_hora"
    t.string  "relato_doenca", limit: 50
    t.date    "dt_retorno"
    t.integer "id",                       null: false
    t.string  "loginsh_pac",              null: false
    t.string  "loginsh_med",              null: false
    t.index ["id"], name: "consultations_id_key", unique: true, using: :btree
    t.index ["loginsh_med"], name: "consultations_loginsh_med_key", unique: true, using: :btree
    t.index ["loginsh_pac"], name: "consultations_loginsh_pac_key", unique: true, using: :btree
  end

  create_table "consulting_rooms", primary_key: ["sala", "bloco", "cod_us"], force: :cascade do |t|
    t.integer "sala",             null: false
    t.string  "bloco",  limit: 1, null: false
    t.integer "cod_us",           null: false
    t.index ["bloco"], name: "consulting_rooms_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "consulting_rooms_cod_us_key", unique: true, using: :btree
    t.index ["sala"], name: "consulting_rooms_sala_key", unique: true, using: :btree
  end

  create_table "directors", primary_key: "loginsh", id: :string, force: :cascade do |t|
  end

  create_table "doctor_specialties", primary_key: ["codcbo", "loginsh_med"], force: :cascade do |t|
    t.integer "codcbo",      null: false
    t.string  "loginsh_med", null: false
    t.index ["codcbo"], name: "doctor_specialties_codcbo_key", unique: true, using: :btree
    t.index ["loginsh_med"], name: "doctor_specialties_loginsh_med_key", unique: true, using: :btree
  end

  create_table "doctors", primary_key: "loginsh", id: :string, force: :cascade do |t|
    t.integer "crm"
    t.index ["crm"], name: "doctors_crm_key", unique: true, using: :btree
  end

  create_table "drug_types", primary_key: "nome", id: :string, force: :cascade do |t|
    t.string "fabricante",       limit: 20
    t.string "tarja",            limit: 20
    t.string "descricao",        limit: 300
    t.string "contraindicacoes", limit: 300
  end

  create_table "employee_works", id: false, force: :cascade do |t|
    t.integer "num_hrs_por_dia"
    t.integer "num_dias_por_semana"
    t.string  "loginsh"
    t.integer "sala"
    t.string  "bloco",               limit: 1
    t.integer "cod_us"
    t.index ["bloco"], name: "employee_works_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "employee_works_cod_us_key", unique: true, using: :btree
    t.index ["loginsh"], name: "employee_works_loginsh_key", unique: true, using: :btree
    t.index ["sala"], name: "employee_works_sala_key", unique: true, using: :btree
  end

  create_table "employees", primary_key: "loginsh", id: :string, force: :cascade do |t|
    t.integer "cpf"
    t.index ["cpf"], name: "employees_cpf_key", unique: true, using: :btree
  end

  create_table "health_units", primary_key: ["cod", "loginsh_dir"], force: :cascade do |t|
    t.string  "tipo",         limit: 30
    t.string  "edificacao",   limit: 30
    t.string  "reg_juridico", limit: 20
    t.string  "bandeira",     limit: 20
    t.string  "porte",        limit: 20
    t.string  "qualidade",    limit: 30
    t.boolean "ehgeral"
    t.string  "end_cidade",   limit: 20
    t.string  "end_rua",      limit: 30
    t.string  "end_bairro",   limit: 30
    t.integer "end_num"
    t.integer "cod",                     null: false
    t.string  "loginsh_dir",             null: false
    t.index ["cod"], name: "health_units_cod_key", unique: true, using: :btree
    t.index ["loginsh_dir"], name: "health_units_loginsh_dir_key", unique: true, using: :btree
  end

  create_table "hospital_rooms", primary_key: ["sala", "bloco", "cod_us"], force: :cascade do |t|
    t.integer "andar"
    t.integer "sala",             null: false
    t.string  "bloco",  limit: 1, null: false
    t.integer "cod_us",           null: false
    t.index ["bloco"], name: "hospital_rooms_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "hospital_rooms_cod_us_key", unique: true, using: :btree
    t.index ["sala"], name: "hospital_rooms_sala_key", unique: true, using: :btree
  end

  create_table "nurses", primary_key: "loginsh", id: :string, force: :cascade do |t|
    t.integer "coren"
    t.index ["coren"], name: "nurses_coren_key", unique: true, using: :btree
  end

  create_table "observation_rooms", primary_key: ["sala", "bloco", "cod_us"], force: :cascade do |t|
    t.string  "alimentacao_geral", limit: 60
    t.integer "num_leitos_uso"
    t.integer "num_leitos"
    t.string  "grau_risco",        limit: 20
    t.string  "tempo_visita"
    t.integer "sala",                         null: false
    t.string  "bloco",             limit: 1,  null: false
    t.integer "cod_us",                       null: false
    t.index ["bloco"], name: "observation_rooms_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "observation_rooms_cod_us_key", unique: true, using: :btree
    t.index ["sala"], name: "observation_rooms_sala_key", unique: true, using: :btree
  end

  create_table "patient_units", primary_key: ["cod_us", "loginsh_pac"], force: :cascade do |t|
    t.date    "data_vinculo"
    t.boolean "ehconveniado"
    t.decimal "mensalidade",  precision: 6, scale: 2
    t.integer "cod_us",                               null: false
    t.string  "loginsh_pac",                          null: false
    t.index ["cod_us"], name: "patient_units_cod_us_key", unique: true, using: :btree
    t.index ["loginsh_pac"], name: "patient_units_loginsh_pac_key", unique: true, using: :btree
  end

  create_table "patients", primary_key: "loginsh", id: :string, force: :cascade do |t|
    t.integer "num_carteira"
    t.index ["num_carteira"], name: "patients_num_carteira_key", unique: true, using: :btree
  end

  create_table "pharmacies", primary_key: ["sala", "bloco", "cod_us"], force: :cascade do |t|
    t.string  "nome",        limit: 20
    t.integer "capacidade"
    t.integer "qtdtotalrem"
    t.decimal "valtotalrem",            precision: 10, scale: 2
    t.integer "sala",                                            null: false
    t.string  "bloco",       limit: 1,                           null: false
    t.integer "cod_us",                                          null: false
    t.index ["bloco"], name: "pharmacies_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "pharmacies_cod_us_key", unique: true, using: :btree
    t.index ["sala"], name: "pharmacies_sala_key", unique: true, using: :btree
  end

  create_table "pharmacists", primary_key: "loginsh", id: :string, force: :cascade do |t|
    t.integer "crf"
    t.index ["crf"], name: "pharmacists_crf_key", unique: true, using: :btree
  end

  create_table "pharmacy_drugs", primary_key: ["sala", "bloco", "cod_us", "nome_farmaco"], force: :cascade do |t|
    t.decimal "preco_unit",             precision: 6, scale: 2
    t.integer "num_unidades"
    t.date    "data_valid"
    t.date    "data_fabr"
    t.integer "sala",                                           null: false
    t.string  "bloco",        limit: 1,                         null: false
    t.integer "cod_us",                                         null: false
    t.string  "nome_farmaco",                                   null: false
    t.index ["bloco"], name: "pharmacy_drugs_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "pharmacy_drugs_cod_us_key", unique: true, using: :btree
    t.index ["nome_farmaco"], name: "pharmacy_drugs_nome_farmaco_key", unique: true, using: :btree
    t.index ["sala"], name: "pharmacy_drugs_sala_key", unique: true, using: :btree
  end

  create_table "providers", primary_key: ["sala", "bloco", "cod_us"], force: :cascade do |t|
    t.integer "cnpj_fornc"
    t.integer "sala",                 null: false
    t.string  "bloco",      limit: 1, null: false
    t.integer "cod_us",               null: false
    t.index ["bloco"], name: "providers_bloco_key", unique: true, using: :btree
    t.index ["cnpj_fornc"], name: "providers_cnpj_fornc_key", unique: true, using: :btree
    t.index ["cod_us"], name: "providers_cod_us_key", unique: true, using: :btree
    t.index ["sala"], name: "providers_sala_key", unique: true, using: :btree
  end

  create_table "purchase_drugs", primary_key: ["loginsh_pac", "num", "cpf", "nome_farmaco"], force: :cascade do |t|
    t.integer "num_unidades"
    t.date    "dt_valid"
    t.decimal "preco_unit",   precision: 6, scale: 2
    t.string  "nome_farmaco",                         null: false
    t.integer "num",                                  null: false
    t.integer "cpf",                                  null: false
    t.string  "loginsh_pac",                          null: false
    t.index ["cpf"], name: "purchase_drugs_cpf_key", unique: true, using: :btree
    t.index ["loginsh_pac"], name: "purchase_drugs_loginsh_pac_key", unique: true, using: :btree
    t.index ["nome_farmaco"], name: "purchase_drugs_nome_farmaco_key", unique: true, using: :btree
    t.index ["num"], name: "purchase_drugs_num_key", unique: true, using: :btree
  end

  create_table "purchases", primary_key: ["cpf", "num", "loginsh_pac"], force: :cascade do |t|
    t.date    "data"
    t.string  "formapgto",   limit: 20
    t.decimal "valorcompra",            precision: 6, scale: 2
    t.integer "cpf",                                            null: false
    t.integer "num",                                            null: false
    t.string  "loginsh_pac",                                    null: false
    t.index ["cpf"], name: "purchases_cpf_key", unique: true, using: :btree
    t.index ["loginsh_pac"], name: "purchases_loginsh_pac_key", unique: true, using: :btree
    t.index ["num"], name: "purchases_num_key", unique: true, using: :btree
  end

  create_table "recipe_drugs", primary_key: ["id_consulta", "num_receita", "loginsh_pac", "loginsh_med", "farmaco"], force: :cascade do |t|
    t.string  "dosagem",       limit: 30
    t.string  "periodo"
    t.string  "quem_ministra", limit: 20
    t.integer "num_receita",              null: false
    t.integer "id_consulta",              null: false
    t.string  "loginsh_pac",              null: false
    t.string  "loginsh_med",              null: false
    t.string  "farmaco",                  null: false
    t.index ["farmaco"], name: "recipe_drugs_farmaco_key", unique: true, using: :btree
    t.index ["id_consulta"], name: "recipe_drugs_id_consulta_key", unique: true, using: :btree
    t.index ["loginsh_med"], name: "recipe_drugs_loginsh_med_key", unique: true, using: :btree
    t.index ["loginsh_pac"], name: "recipe_drugs_loginsh_pac_key", unique: true, using: :btree
    t.index ["num_receita"], name: "recipe_drugs_num_receita_key", unique: true, using: :btree
  end

  create_table "recipes", primary_key: ["num", "id_consulta", "loginsh_pac", "loginsh_med"], force: :cascade do |t|
    t.integer "num",         null: false
    t.integer "id_consulta", null: false
    t.string  "loginsh_pac", null: false
    t.string  "loginsh_med", null: false
    t.index ["id_consulta"], name: "recipes_id_consulta_key", unique: true, using: :btree
    t.index ["loginsh_med"], name: "recipes_loginsh_med_key", unique: true, using: :btree
    t.index ["loginsh_pac"], name: "recipes_loginsh_pac_key", unique: true, using: :btree
    t.index ["num"], name: "recipes_num_key", unique: true, using: :btree
  end

  create_table "requisition_drugs", primary_key: ["farmaco", "id_req", "cod_us_sol", "sala", "bloco"], force: :cascade do |t|
    t.integer "num_unidades"
    t.string  "farmaco",                null: false
    t.integer "id_req",                 null: false
    t.integer "cod_us_sol",             null: false
    t.integer "sala",                   null: false
    t.string  "bloco",        limit: 1, null: false
    t.index ["bloco"], name: "requisition_drugs_bloco_key", unique: true, using: :btree
    t.index ["cod_us_sol"], name: "requisition_drugs_cod_us_sol_key", unique: true, using: :btree
    t.index ["farmaco"], name: "requisition_drugs_farmaco_key", unique: true, using: :btree
    t.index ["id_req"], name: "requisition_drugs_id_req_key", unique: true, using: :btree
    t.index ["sala"], name: "requisition_drugs_sala_key", unique: true, using: :btree
  end

  create_table "requisitions", primary_key: ["id_req", "cod_us_solicitante", "sala", "bloco"], force: :cascade do |t|
    t.integer "cod_us_farm_pedido"
    t.date    "dt_hora_pedido"
    t.date    "dt_hora_entrega"
    t.integer "id_req",                       null: false
    t.integer "cod_us_solicitante",           null: false
    t.integer "sala",                         null: false
    t.string  "bloco",              limit: 1, null: false
    t.index ["bloco"], name: "requisitions_bloco_key", unique: true, using: :btree
    t.index ["cod_us_solicitante"], name: "requisitions_cod_us_solicitante_key", unique: true, using: :btree
    t.index ["id_req"], name: "requisitions_id_req_key", unique: true, using: :btree
    t.index ["sala"], name: "requisitions_sala_key", unique: true, using: :btree
  end

  create_table "specialties", primary_key: "codcbo", id: :integer, force: :cascade do |t|
    t.string "nome", limit: 30
  end

  create_table "unit_specialties", primary_key: ["cod_us", "codcbo_esp"], force: :cascade do |t|
    t.integer "codcbo_esp", null: false
    t.integer "cod_us",     null: false
    t.index ["cod_us"], name: "unit_specialties_cod_us_key", unique: true, using: :btree
    t.index ["codcbo_esp"], name: "unit_specialties_codcbo_esp_key", unique: true, using: :btree
  end

  create_table "users", primary_key: "loginsh", id: :string, force: :cascade do |t|
    t.string  "email",         limit: 30
    t.string  "cargo",         limit: 20
    t.string  "senhash",       limit: 30
    t.string  "end_cidade",    limit: 20
    t.string  "end_rua",       limit: 30
    t.string  "end_bairro",    limit: 30
    t.integer "end_num"
    t.date    "dt_nasc"
    t.integer "rg"
    t.string  "nome_completo", limit: 80
    t.string  "filiacao_pai",  limit: 80
    t.string  "filiacao_mae",  limit: 80
    t.index ["rg"], name: "users_rg_key", unique: true, using: :btree
    t.index ["senhash"], name: "users_senhash_key", unique: true, using: :btree
  end

  create_table "ward_drugs", primary_key: ["sala", "bloco", "cod_us", "nome_farmaco"], force: :cascade do |t|
    t.float   "fracao_restante"
    t.date    "dt_val"
    t.integer "sala",                      null: false
    t.string  "bloco",           limit: 1, null: false
    t.integer "cod_us",                    null: false
    t.string  "nome_farmaco",              null: false
    t.index ["bloco"], name: "ward_drugs_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "ward_drugs_cod_us_key", unique: true, using: :btree
    t.index ["nome_farmaco"], name: "ward_drugs_nome_farmaco_key", unique: true, using: :btree
    t.index ["sala"], name: "ward_drugs_sala_key", unique: true, using: :btree
  end

  create_table "wards", primary_key: ["sala", "bloco", "cod_us"], force: :cascade do |t|
    t.integer "total_remed_disp"
    t.integer "capacidade_rem"
    t.integer "sala",                       null: false
    t.string  "bloco",            limit: 1, null: false
    t.integer "cod_us",                     null: false
    t.index ["bloco"], name: "wards_bloco_key", unique: true, using: :btree
    t.index ["cod_us"], name: "wards_cod_us_key", unique: true, using: :btree
    t.index ["sala"], name: "wards_sala_key", unique: true, using: :btree
  end

  add_foreign_key "consultations", "doctors", column: "loginsh_med", primary_key: "loginsh", name: "consultations_loginsh_med_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "consultations", "patients", column: "loginsh_pac", primary_key: "loginsh", name: "consultations_loginsh_pac_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "consulting_rooms", "consulting_rooms", column: "sala", primary_key: "sala", name: "consulting_rooms_sala_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "directors", "users", column: "loginsh", primary_key: "loginsh", name: "directors_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "doctor_specialties", "doctors", column: "loginsh_med", primary_key: "loginsh", name: "doctor_specialties_loginsh_med_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "doctor_specialties", "specialties", column: "codcbo", primary_key: "codcbo", name: "doctor_specialties_codcbo_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "doctors", "employees", column: "loginsh", primary_key: "loginsh", name: "doctors_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employee_works", "consulting_rooms", column: "bloco", primary_key: "bloco", name: "employee_works_bloco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employee_works", "employees", column: "loginsh", primary_key: "loginsh", name: "employee_works_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "employees", "users", column: "loginsh", primary_key: "loginsh", name: "employees_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "health_units", "directors", column: "loginsh_dir", primary_key: "loginsh", name: "health_units_loginsh_dir_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "hospital_rooms", "health_units", column: "cod_us", primary_key: "cod", name: "hospital_rooms_cod_us_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "nurses", "employees", column: "loginsh", primary_key: "loginsh", name: "nurses_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "observation_rooms", "consulting_rooms", column: "sala", primary_key: "sala", name: "observation_rooms_sala_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "patient_units", "health_units", column: "cod_us", primary_key: "cod", name: "patient_units_cod_us_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "patient_units", "patients", column: "loginsh_pac", primary_key: "loginsh", name: "patient_units_loginsh_pac_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "patients", "users", column: "loginsh", primary_key: "loginsh", name: "patients_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pharmacies", "consulting_rooms", column: "sala", primary_key: "sala", name: "pharmacies_sala_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pharmacists", "employees", column: "loginsh", primary_key: "loginsh", name: "pharmacists_loginsh_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pharmacy_drugs", "drug_types", column: "nome_farmaco", primary_key: "nome", name: "pharmacy_drugs_nome_farmaco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "pharmacy_drugs", "pharmacies", column: "sala", primary_key: "sala", name: "pharmacy_drugs_sala_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "providers", "pharmacies", column: "sala", primary_key: "sala", name: "providers_sala_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchase_drugs", "drug_types", column: "nome_farmaco", primary_key: "nome", name: "purchase_drugs_nome_farmaco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchase_drugs", "purchases", column: "loginsh_pac", primary_key: "loginsh_pac", name: "purchase_drugs_loginsh_pac_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchases", "patients", column: "loginsh_pac", primary_key: "loginsh", name: "purchases_loginsh_pac_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_drugs", "drug_types", column: "farmaco", primary_key: "nome", name: "recipe_drugs_farmaco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipe_drugs", "recipes", column: "num_receita", primary_key: "num", name: "recipe_drugs_num_receita_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "recipes", "consultations", column: "id_consulta", name: "recipes_id_consulta_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "requisition_drugs", "drug_types", column: "farmaco", primary_key: "nome", name: "requisition_drugs_farmaco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "requisition_drugs", "requisitions", column: "id_req", primary_key: "id_req", name: "requisition_drugs_id_req_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "requisitions", "wards", column: "bloco", primary_key: "bloco", name: "requisitions_bloco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "unit_specialties", "health_units", column: "cod_us", primary_key: "cod", name: "unit_specialties_cod_us_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "unit_specialties", "specialties", column: "codcbo_esp", primary_key: "codcbo", name: "unit_specialties_codcbo_esp_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ward_drugs", "drug_types", column: "nome_farmaco", primary_key: "nome", name: "ward_drugs_nome_farmaco_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ward_drugs", "wards", column: "sala", primary_key: "sala", name: "ward_drugs_sala_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "wards", "consulting_rooms", column: "sala", primary_key: "sala", name: "wards_sala_fkey", on_update: :cascade, on_delete: :cascade
end
