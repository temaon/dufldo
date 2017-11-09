class Modules::Game::ExtraTime < Timeline
 belongs_to :game
 rails_admin do
  visible false
  label 'Добавочное время'
  exclude_fields :type,
                 :created_at,
                 :updated_at
 end
end