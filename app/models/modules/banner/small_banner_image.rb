class Modules::Banner::SmallBannerImage < Attachment
  has_attached_file :file, styles: {thumb: '116x116', medium: '360x232#', gallery: '360x200#', default_url: 'default.png'}
  validates_attachment_content_type :file, content_type: /\Aimage/
  belongs_to :assetable, polymorphic: true, inverse_of: :main_image

  rails_admin do
    visible false
    exclude_fields :type
  end
end