class NewsCategory < Category
  include Concerns::Sluggable

  #Relations
  has_many :posts, dependent: :destroy, inverse_of: :news_category, foreign_key: :category_id, source: :news, class_name: 'News'
  accepts_nested_attributes_for :posts, allow_destroy: true

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  #Scopes
  default_scope -> {includes(parent: :slug)}

  def self.get_default_properties
    {title: 'Новости', slug: '/news'}
  end

end