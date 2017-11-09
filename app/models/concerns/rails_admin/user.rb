module RailsAdmin::User
  extend ActiveSupport::Concern

  included do
    rails_admin do
      navigation_label 'Пользователи'
      navigation_icon 'icon-user'

      label 'Все'
      label_plural 'Все'

      exclude_fields   :team_id,
                       :news,
                       :type,
                       :created_at,
                       :updated_at,
                       :reset_password_sent_at,
                       :remember_created_at,
                       :current_sign_in_at,
                       :current_sign_in_ip,
                       :sign_in_count,
                       :last_sign_in_at,
                       :last_sign_in_ip,
                       :confirmation_sent_at,
                       :confirmation_token,
                       :watches_count,
                       :impressions,
                       :comments,
                       :subscriptions,
                       :password,
                       :password_confirmation

        list do
          field :username
          field :email
        end
    end
  end
end