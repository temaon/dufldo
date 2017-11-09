module RailsAdmin::TournamentCategory
  extend ActiveSupport::Concern

  included do
    rails_admin do
      object_label_method :title
      label 'Меню турниров'
      label_plural 'Меню турниров'
      navigation_icon 'icon-folder-open'

      field :content, :ck_editor

      field :has_nesting do
        visible false
      end

      field :parent do
        visible false
      end

      field :children do
        visible false
      end


      list do
        field :title do
        end
      end


      include_fields :name, :content, :parent, :children, :slug, :main_image

      field :slug do
        label 'URL'
      end
    end
  end

end

