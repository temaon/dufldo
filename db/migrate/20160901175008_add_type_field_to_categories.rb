class AddTypeFieldToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :type, :string, limit: 40
  end
end
