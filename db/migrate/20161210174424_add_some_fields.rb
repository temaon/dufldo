class AddSomeFields < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :watches_count, :integer, default: 0
  end
end
