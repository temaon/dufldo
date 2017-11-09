class AddEnumFieldsToModels < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :template, :integer, default: 0
    add_column :posts, :template, :integer, default: 0
  end
end
