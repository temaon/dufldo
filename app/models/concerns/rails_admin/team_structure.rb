module RailsAdmin::TeamStructure
  extend ActiveSupport::Concern
  included do
    rails_admin do
      visible false
      label 'Состав команды'
      label_plural 'Составы команд'
      field :name
      field :players do
        inline_add false
        nested_form false
        associated_collection_scope do
          team = bindings[:object].team
          Proc.new { |scope|
            team.present? ? scope.where('team_id=?', team.id) : scope.limit(0)
          }
        end
      end

      create do
        exclude_fields :players
      end
    end
  end
end