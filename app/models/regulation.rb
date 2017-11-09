class Regulation < ApplicationRecord
  has_and_belongs_to_many :tournaments

  rails_admin do
    parent Tournament
    label 'Регламент'
    label_plural 'Регламенты'
    navigation_icon 'icon-hand'
    include_all_fields

    field :description, :ck_editor

    exclude_fields :created_at,
                   :updated_at,
                   :tournaments
  end
end
