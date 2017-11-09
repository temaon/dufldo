class AddSomeFieldsToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :results, :goals_balls, :integer
    add_column :results, :missed_balls, :integer
  end
end
