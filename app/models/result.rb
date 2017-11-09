class Result < ApplicationRecord

  belongs_to :team_structure, inverse_of: :results, class_name: 'TeamStructure'

  belongs_to :tournament, inverse_of: :results, class_name: 'Tournament'

  validates_uniqueness_of :team_structure, scope: :tournament

  rails_admin do
    parent Tournament

    include_all_fields

    label 'Результат'
    label_plural 'Результаты'
    navigation_icon 'icon-chart'
    
    field :team_structure do
      inline_add false
      nested_form false
      extend Concerns::Extensions
      associated_collection_scope do
        object, value = self.find_nested_query(bindings[:controller].params, :team_structures)
        Proc.new { |scope|
          object.present? ? (value.present? ? value : scope.limit(0)) : scope
        }
      end
    end

  end

end
