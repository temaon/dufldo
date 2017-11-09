module RailsAdmin::Game
  extend ActiveSupport::Concern

  included do
    rails_admin do
      parent Tournament

      label 'Игра'
      label_plural 'Игры'
      navigation_icon 'icon-gamepad'

      group 'Главная информация' do
        field :round do
          inverse_of :games
          associated_collection_scope do
            extend Concerns::Extensions
            object, value = self.find_nested_query(bindings[:controller].params, :rounds)
            Proc.new { |scope|
              (object.present? && object.class.to_s == 'Tournament') ? (value.present? ? value : scope.limit(0)) : scope
            }
          end
        end

        field :home_team_structure do
          associated_collection_scope do
            extend Concerns::Extensions
            object, value = self.find_nested_query(bindings[:controller].params, :team_structures)
            Proc.new { |scope|
              (object.present? && object.class.to_s == 'Tournament') ? (value.present? ? value : scope.limit(0)) : scope
            }
          end
        end

        field :guest_team_structure do
          associated_collection_scope do
            extend Concerns::Extensions
            object, value = self.find_nested_query(bindings[:controller].params, :team_structures)
            Proc.new { |scope|
              (object.present? && object.class.to_s == 'Tournament') ? (value.present? ? value : scope.limit(0)) : scope
            }
          end
        end
      end

      group 'Дополнительная информация' do
        active false
        field :statistic, :ck_editor
        field :date
        field :home_team_result
        field :guest_team_result
        field :first_time
        field :second_time
        field :extra_time
      end

      group 'Галерея' do
        active false
        field :video
        field :images
      end

      group 'Cтатистическа информация' do
        active false
        field :watches_count do
          read_only true
        end
      end

    end

  end
end