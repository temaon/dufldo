module RailsAdmin::News
  extend ActiveSupport::Concern

  included do
    rails_admin do
      parent NewsCategory
      include_all_fields
      label 'Новость'
      label_plural 'Новости'
      navigation_icon 'icon-news'

      group 'Главная информация' do
        field :title
        field :date
        field :is_main
        field :short_description
        field :description, :ck_editor
        field :news_category do
          nested_form false
          inline_add false
          inline_edit false
        end
      end

      group 'SEO' do
        active false
        field :slug
        field :tag_list do
          partial 'tag_list_with_autocomplete'
          # the option sets max count of suggestions (default is 100); set -1 to abolish the limit
        end

      end

      group 'Галерея' do
        active false
        field :video
        field :images
      end

      group 'Дополнительная информация' do
        active false
        field :user do
          visible true
          help ''
          default_value do
            def selected_id
              bindings[:view]._current_user
            end
          end
        end
        field :is_commentable, :boolean
        field :thread
      end

      group 'Cтатистическа информация' do
        active false
        field :watches_count do
          read_only true
        end
      end

      list do
        exclude_fields :updated_at,
                       :description,
                       :short_description,
                       :slug,
                       :user,
                       :tag_list
        field :images do
          pretty_value do
            bindings[:view].tag(:img, { src: bindings[:object].images.first.url(:thumb) }) if bindings[:object].images.present?
          end
        end
      end

      create do
        exclude_fields :thread, :impressions
      end

      edit do
        exclude_fields :thread, :impressions
      end

      show do
        exclude_fields :updated_at,
                       :description
        field :images do
          inverse_of :assetable
          pretty_value do
            if bindings[:object].images.present?
              result = ''
              bindings[:object].images.each do |item|
                result += bindings[:view].tag(:img, { src: item.url(:thumb) })
              end
              result.html_safe
            end
          end
        end
      end
    end
  end
end