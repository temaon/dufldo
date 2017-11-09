module RailsAdmin::Round
  extend ActiveSupport::Concern

  included do
    rails_admin do
      parent ::Tournament

      label 'Тур'
      label_plural 'Туры'
      navigation_icon 'icon-list-ol'

      object_label_method :title

      include_fields :name, :games, :statistic

      exclude_fields :created_at,
                     :updated_at

      field :tournament do
        searchable [::Tournament => :title]
        queryable true
      end

      field :statistic, :ck_editor

      list do
        include_fields :name, :statistic, :tournament, :games
      end

    end
  end
end