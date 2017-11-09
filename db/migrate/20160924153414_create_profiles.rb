class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :full_name
      t.string :position
      t.date :birthday
      t.string :place
      t.integer :height
      t.integer :weight
      t.text :description
      t.references :user, index: true
      t.timestamps
    end

    add_column :profiles, :type, :string, limit: 40
    remove_column :users, :description, :text if column_exists? :users, :description
    remove_column :users, :name, :string if column_exists? :users, :name
  end
end
