class TournamentCategory < Category
  include Concerns::Sluggable
  include RailsAdmin::TournamentCategory

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  has_many :posts, dependent: :destroy, inverse_of: :tournament_category, foreign_key: :category_id, source: :tournament, class_name: 'Tournament'
  accepts_nested_attributes_for :posts, allow_destroy: true

  default_scope -> {includes(parent: :slug)}

end