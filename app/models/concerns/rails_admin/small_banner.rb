module RailsAdmin::SmallBanner
  extend ActiveSupport::Concern

  included do
    rails_admin do
      navigation_icon 'icon-tv'

      label 'Баннер партнера'
      label_plural 'Баннеры партнеров'

      exclude_fields   :type,
                       :created_at,
                       :updated_at,
                       :date,
                       :show,
                       :description

      group 'Главная информация' do
        field :name
        field :url
      end

      group 'Дополнительная информация' do
        field :main_image
        field :position
      end

      list do
        field :name
        field :url
      end
    end
  end
end