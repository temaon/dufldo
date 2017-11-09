module RailsAdmin::UserProfile
  extend ActiveSupport::Concern
  included do
    rails_admin do
      visible false
      exclude_fields :type
    end
  end
end