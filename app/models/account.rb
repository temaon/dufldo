class Account < User
  include RailsAdmin::Account

  has_one :photo, as: :assetable, class_name: 'Modules::Account::Image', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :photo, allow_destroy: true

  has_one :profile, class_name: 'UserProfile', dependent: :destroy, foreign_key: :user_id, inverse_of: :player
  accepts_nested_attributes_for :profile, allow_destroy: true

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

end