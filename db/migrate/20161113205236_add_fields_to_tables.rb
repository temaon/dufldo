class AddFieldsToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :date, :datetime
    add_column :news, :is_main, :boolean, default: true
    add_column :tournaments, :is_main, :boolean, default: true
    add_column :tournaments, :short_description, :text
  end
end
