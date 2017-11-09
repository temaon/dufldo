module RailsAdmin::Tournament
  extend ActiveSupport::Concern

  included do
    rails_admin do

      parent TournamentCategory

      include_all_fields

      label 'Турнир'
      label_plural 'Турниры'
      navigation_icon 'icon-trophy'
      exclude_fields :teams, :results

      group 'Основная информация' do
        field :title do
          label 'Название'
        end
        field :short_description
        field :description, :ck_editor
        field :tournament_category do
          nested_form false
          inline_add false
          inline_edit false
        end
      end

      group 'Составы' do
        field :team_structures do
          label 'Состав команд'
          nested_form false
          inline_add false
        end
      end

      group 'Галерея' do
        active false
        field :images
      end

      group 'Регламент' do
        active false
        field :regulations
        field :documents
      end

      group 'Результаты' do
        active false
        field :rounds
        field :results
        field :recent_results do
          label 'Последние результаты'
          read_only true
        end
        field :future_games do
          label 'Анонс матчей'
          read_only true
        end
      end

      group 'Дополнительная информация' do
        active false
        field :is_main, :boolean
        field :is_commentable, :boolean
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
        field :tag_list
      end

      list do
        exclude_fields :updated_at,
                       :description,
                       :created_at,
                       :images,
                       :tag_list,
                       :slug,
                       :games
      end

      create do
        exclude_fields :thread, :impressions, :games
      end

      edit do
        exclude_fields :thread, :impressions, :games
      end

      show do
        exclude_fields :updated_at,
                       :description
        field :results
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