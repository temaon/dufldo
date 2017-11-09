class PlayerProfile < Profile
  include RailsAdmin::PlayerProfile
  belongs_to :player, inverse_of: :profile, foreign_key: :user_id
end
