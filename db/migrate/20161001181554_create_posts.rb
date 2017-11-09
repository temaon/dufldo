class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :description
      t.references :category, index: true
      t.timestamps
    end

    add_column :categories, :content, :text
    add_column :categories, :has_nesting, :boolean, default: false
  end
end
