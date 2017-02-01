namespace :localizable do
  task setup: :environment do
    ActiveRecord::Schema.define do
      unless ActiveRecord::Base.connection.tables.include? 'localized_pages'
        create_table :localized_pages do |t|
          t.string :locale, null: false
          t.string :page_uid, null: false

          t.timestamps null: false
        end
      end

      unless ActiveRecord::Base.connection.tables.include? 'localized_values'
        create_table :localized_values do |t|
          t.references :localized_page, index: true, foreign_key: true
          t.string :key, null: false
          t.string :type
          t.string :value

          t.timestamps null: false
        end
      end
    end
  end
end
