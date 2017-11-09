class Timeline < ApplicationRecord

  has_many :game_events, dependent: :destroy, inverse_of: :timeline, class_name: 'GameEvent'
  accepts_nested_attributes_for :game_events, allow_destroy: true

  belongs_to :game

  rails_admin do
    visible false
    exclude_fields :type,
                   :created_at,
                   :updated_at
  end

end
