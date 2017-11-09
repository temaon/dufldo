class CreateRegulations < ActiveRecord::Migration[5.0]
  def change
    create_table :regulations do |t|
      t.string :title
      t.text :description
      t.timestamps
    end

    create_table :regulations_tournaments do |t|
      t.references :regulation, index: true
      t.references :tournament, index: true
      t.timestamps
    end
  end
end
