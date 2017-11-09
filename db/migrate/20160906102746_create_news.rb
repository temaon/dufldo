class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :short_description
      t.text :description
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
