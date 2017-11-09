module RailsAdmin::Team
  extend ActiveSupport::Concern

  included do
    rails_admin do
      include_all_fields

      label 'Команда'
      label_plural 'Команды'

      navigation_icon 'icon-users'
      group 'Основная информация' do
        field :name
        field :short_name
        field :founded
        field :trainer
        field :location
        field :description, :ck_editor
        field :players do
          nested_form false
          inline_add true
        end
      end

      group 'Дополнительная информация' do
        field :team_structures
      end

      group 'Галерея' do
        active false
        field :logo
        field :main_image
        field :images
      end

      group 'Cтатистическа информация' do
        active false
        field :watches_count do
          read_only true
        end
      end

      group 'SEO' do
        active false
        field :slug
      end

      create do
        exclude_fields :team_structures, :thread, :impressions, :created_at, :updated_at
      end

      list do
        exclude_fields :team_structures, :thread, :impressions, :created_at, :updated_at
      end

      edit do
        exclude_fields :thread, :impressions, :impressions, :created_at, :updated_at
      end

    end
  end
end