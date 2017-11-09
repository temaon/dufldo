class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.references :round, index: true
      t.references :home_team, index: true
      t.references :guest_team, index: true
      t.datetime :date
      t.integer :home_team_result
      t.integer :guest_team_result
      t.timestamps
    end
  end
end
