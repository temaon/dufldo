class AddEnumFieldToBanner < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :position, :integer, default: 0
  end
end
