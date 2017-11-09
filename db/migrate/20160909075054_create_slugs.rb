class CreateSlugs < ActiveRecord::Migration[5.0]
  def change
    create_table :slugs do |t|
      t.string :slug
      t.references :slugable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
