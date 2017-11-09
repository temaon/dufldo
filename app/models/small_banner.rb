class SmallBanner < Banner
  include RailsAdmin::SmallBanner

  has_one :main_image, as: :assetable, class_name: 'Modules::Banner::SmallBannerImage', dependent: :delete, inverse_of: :assetable
  accepts_nested_attributes_for :main_image, allow_destroy: true

  default_scope -> {includes(:main_image)}

  enum position: [:left, :right]

  scope :for_showing, -> {where(show: true).first}
end