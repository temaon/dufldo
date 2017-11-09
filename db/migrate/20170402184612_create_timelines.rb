class CreateTimelines < ActiveRecord::Migration[5.0]
  def change
    create_table :timelines do |t|
      t.integer :length
      t.string :type
      t.references :game, foreign_key: true, index: true
      t.timestamps
    end
  end
end
