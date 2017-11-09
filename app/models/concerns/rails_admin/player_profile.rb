module RailsAdmin::PlayerProfile
  extend ActiveSupport::Concern
  included do
    rails_admin do
      visible false
      exclude_fields :type

      field :description, :ck_editor
    end
  end
end