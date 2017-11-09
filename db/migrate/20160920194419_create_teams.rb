class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    add_column :users, :team_id, :integer, index: true
    add_column :users, :type, :string, index: true
    add_column :users, :description, :text

    # create_table :memberships do |t|
    #   t.references :player, index: true
    #   t.references :team, index: true
    #   t.boolean :captain
    # end
  end
end
