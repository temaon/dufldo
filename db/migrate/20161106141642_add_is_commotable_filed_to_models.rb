class AddIsCommotableFiledToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :is_commentable, :boolean, default: true
    add_column :tournaments, :is_commentable, :boolean, default: true
  end
end
