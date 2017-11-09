class CreateTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.text :description
      t.belongs_to :category, index: true, foreign_key: true
      t.timestamps
    end
  end
end
