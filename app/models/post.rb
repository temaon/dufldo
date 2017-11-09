class Post < ApplicationRecord

  include Concerns::Sluggable
  include Concerns::Commentable

  before_save :set_template

  belongs_to :static_page, foreign_key: :category_id

  has_many :images, as: :assetable, class_name: 'Modules::Post::Image', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :videos, as: :assetable, class_name: 'Modules::Post::Video', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :videos, allow_destroy: true

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  enum template: [ :default, :contact, :photo_gallery, :video_gallery ]

  def slug_field
    :name
  end

  def slug_field_nested
    :static_page
  end

  rails_admin do
    parent StaticPage

    include_all_fields

    field :description, :ck_editor

    exclude_fields :created_at,
                  :updated_at,
                  :template

    create do
      exclude_fields :thread, :impressions
    end

    edit do
      exclude_fields :thread, :impressions
    end

  end

  def create_associated_image(image)
    images.create(file: image)
  end

  scope :finder, -> (data) {includes(:static_page, :images, :slug).references(:static_page, :images, :slug).where('posts.id=? OR slugs.slug=?', data, data)}
  scope :latest, -> (limit = LATEST_NEWS_LIMIT){order(created_at: :desc).limit(limit)}
  scope :main_scope, -> (limit = LATEST_NEWS_LIMIT){where('posts.is_main =?', true).latest(limit)}
  scope :popular_news, -> (limit = POPULAR_NEWS_LIMIT){includes(:static_page, :images, :slug).where('posts.watches_count >?', 0).order('posts.watches_count DESC').limit(limit)}
  scope :by_date, -> (day, month, year) do
    query_str = "#{year.present? ? 'YEAR(date) = ' + year.to_s : nil} #{month.present? ? 'and MONTH(date) = ' + month.to_s : nil} #{day.present? ? 'and DAY(date) = ' + day.to_s : nil}"
    where(query_str)
  end

  default_scope ->{includes(:static_page, :images, :slug)}

  private

  def set_template
    self.template = self.static_page.template
  end

end
