class AddWatchesCounterToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :watches_count, :integer, default: 0
    add_column :games, :watches_count, :integer, default: 0
    add_column :news, :watches_count, :integer, default: 0
    add_column :categories, :watches_count, :integer, default: 0
    add_column :posts, :watches_count, :integer, default: 0
    add_column :tournaments, :watches_count, :integer, default: 0
  end
end
