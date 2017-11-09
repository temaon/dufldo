class CreateTeamStructures < ActiveRecord::Migration[5.0]
  def change
    create_table :team_structures do |t|
      t.string :name
      t.references :team, index: true
      t.timestamps
    end

    create_table :team_structures_players do |t|
      t.references :team_structure, index: true
      t.references :player, index: true
      t.timestamps
    end

  end
end
