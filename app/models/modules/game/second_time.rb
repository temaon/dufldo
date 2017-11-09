class Modules::Game::SecondTime < Timeline
  belongs_to :game
  rails_admin do
    visible false
    label 'Второй тайм'
    exclude_fields :type,
                   :created_at,
                   :updated_at
  end
end