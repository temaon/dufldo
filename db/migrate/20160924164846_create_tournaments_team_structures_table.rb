class CreateTournamentsTeamStructuresTable < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments_team_structures do |t|
      t.references :tournament, index: true
      t.references :team_structure, index: true
      t.timestamps
    end
  end
end
