class Modules::Game::FirstTime < Timeline
  belongs_to :game
  rails_admin do
    visible false
    label 'Первый тайм'
    exclude_fields :type,
                   :created_at,
                   :updated_at
  end
end