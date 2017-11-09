class MainBanner < Banner
  include RailsAdmin::MainBanner

  has_one :main_image, as: :assetable, class_name: 'Modules::Banner::MainBannerImage', dependent: :delete, inverse_of: :assetable
  accepts_nested_attributes_for :main_image, allow_destroy: true

  default_scope -> {includes(:main_image)}

  scope :for_showing, -> {where(show: true).first}

  validates_presence_of :main_image
end