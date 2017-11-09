class StaticPage < Category
  include Concerns::Sluggable

  has_many :posts, dependent: :delete_all, foreign_key: :category_id, class_name: 'Post'
  accepts_nested_attributes_for :posts, allow_destroy: true

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  enum template: [ :default, :contact, :photo_gallery, :video_gallery ]

end