class AddShortTitleToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :short_name, :string
  end
end
