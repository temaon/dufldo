class Modules::Team::Image < Attachment
  has_attached_file :file, styles: {thumb: '116x116#', medium: '300x200#', gallery: '1600x545#', default_url: 'default.png'}
  validates_attachment_content_type :file, content_type: /\Aimage/
  belongs_to :assetable, polymorphic: true, inverse_of: :main_image

  def title
    "#{id}-image"
  end

  rails_admin do
    visible false
    exclude_fields :type
  end

end