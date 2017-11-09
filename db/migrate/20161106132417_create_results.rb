class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :tournament, index: true
      t.references :team_structure, index: true
      t.integer :place
      t.integer :count_games
      t.integer :count_wins
      t.integer :count_draws
      t.integer :count_losings
      t.integer :differences
      t.integer :score
      t.timestamps
    end
  end
end
