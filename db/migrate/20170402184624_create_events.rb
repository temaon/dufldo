class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :game_events do |t|
      t.references :timeline, foreign_key: true
      t.belongs_to :player
      t.string :description
      t.integer :time
      t.integer :event_type
      t.timestamps
    end

    add_foreign_key :game_events, :users, column: :player_id
  end
end
