class UserProfile < Profile
  include RailsAdmin::UserProfile
  belongs_to :player, inverse_of: :profile, foreign_key: :user_id
end
