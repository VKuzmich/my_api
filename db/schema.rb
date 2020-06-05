

ActiveRecord::Schema.define(version: 2020_05_14_082741) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'transformers', force: :cascade do |t|
    t.string 'user_url'
    t.string 'nickname'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end
end
