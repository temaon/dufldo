class CreateCareers < ActiveRecord::Migration[5.0]
  def change
    create_table :careers do |t|
      t.integer :matches_count
      t.integer :goals_count
      t.references :player, index: true
      t.timestamps
    end
  end
end
