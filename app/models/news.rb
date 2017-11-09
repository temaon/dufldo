class News < ApplicationRecord

  include Concerns::Sluggable
  include RailsAdmin::News
  include Concerns::Commentable

  LATEST_NEWS_LIMIT = 9
  POPULAR_NEWS_LIMIT = 10

  #Relations
  alias_attribute :category, :news_category
  belongs_to :news_category, inverse_of: :posts, class_name: 'NewsCategory', foreign_key: :category_id

  has_many :images, as: :assetable, class_name: 'Modules::News::Image', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_one :video, as: :assetable, class_name: 'Modules::News::Video', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :video, allow_destroy: true

  belongs_to :user, inverse_of: :news

  #Validators
  validates :title, presence: true
  validates :news_category, presence: true
  validates :description, presence: true

  #Impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  acts_as_taggable

  acts_as_taggable_on :tags

  paginates_per 10

  searchable auto_index: true, auto_remove: true do
    text :description
    text :title
    string  :slug_title do
      slug.try(:slug)
    end
  end

  #Scopes
  default_scope ->{includes(:news_category, :images, :slug)}

  scope :finder, -> (data) {includes(:news_category, :images, :slug).references(:news_category, :images, :slug).where('news.id=? OR slugs.slug=?', data, data)}
  scope :latest, -> (limit = LATEST_NEWS_LIMIT){order(created_at: :desc).limit(limit)}
  scope :main_scope, -> (limit = LATEST_NEWS_LIMIT){where('news.is_main =?', true).latest(limit)}
  scope :popular_news, -> (limit = POPULAR_NEWS_LIMIT){includes(:news_category, :images, :slug).where('news.watches_count >?', 0).order('news.watches_count DESC').limit(limit)}
  scope :by_date, -> (day, month, year) do
    query_str = "#{year.present? ? 'YEAR(date) = ' + year.to_s : nil} #{month.present? ? 'and MONTH(date) = ' + month.to_s : nil} #{day.present? ? 'and DAY(date) = ' + day.to_s : nil}"
    where(query_str)
  end

  def create_associated_image(image)
    images.create(file: image)
  end

  #Url-generation
  def slug_field
    :title
  end

  def slug_field_nested
    :category
  end

end
