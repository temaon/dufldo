module RailsAdmin::Player
  extend ActiveSupport::Concern

  included do
    rails_admin do
      include_all_fields

      label 'Игрок'
      label_plural 'Игроки'
      navigation_icon 'icon-futbol'

      group 'Информация аккаунта' do
        active false
        field :username
        field :email
        field :password
        field :password_confirmation
      end

      group 'Информация профиля' do
        field :team
        field :photo
        field :profile do
          visible true
        end
        field :career
      end

      group 'Настройки аккаунта' do
        active false
        field :confirmed_at
        field :slug
        field :roles
      end

      field :team do
        inline_add false
        inline_edit false
      end

      exclude_fields   :news,
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
                       :team_structures,
                       :confirmation_sent_at,
                       :confirmation_token,
                       :watches_count,
                       :impressions,
                       :comments,
                       :subscriptions,
                       :password,
                       :password_confirmation,
                       :home_team_games,
                       :team_structures,
                       :guest_team_games

      list do

        field :profile
        field :username
        field :team
        field :email
      end
    end
  end
end