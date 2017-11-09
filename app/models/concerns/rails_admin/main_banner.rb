module RailsAdmin::MainBanner
  extend ActiveSupport::Concern

  included do
    rails_admin do
      navigation_icon 'icon-tv'

      label 'Основной баннер'
      label_plural 'Основные баннеры'

      exclude_fields   :type,
                       :created_at,
                       :position,
                       :updated_at

      group 'Главная информация' do
        field :name
        field :description, :ck_editor
        field :show
      end

      group 'Дополнительная информация' do
        field :date
        field :url
        field :main_image
      end

      list do
        field :name
        field :url
      end
    end
  end
end