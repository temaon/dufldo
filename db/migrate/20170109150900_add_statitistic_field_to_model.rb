class AddStatitisticFieldToModel < ActiveRecord::Migration[5.0]
  def change
    add_column :rounds, :statistic, :text, limit: 4294967295
    add_column :games, :statistic, :text, limit: 4294967295

    add_column :teams, :founded, :integer, limit: 4
    add_column :teams, :location, :string
    add_column :teams, :trainer, :string
  end
end
