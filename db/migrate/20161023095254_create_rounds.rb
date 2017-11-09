class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.string :name
      t.references :tournament, index: true
      t.timestamps
    end
  end
end
