class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|
      t.string :name
      t.string :url
      t.datetime :date
      t.text :description
      t.string :type, limit: 40
      t.boolean :show, default: true
      t.timestamps
    end
  end
end
