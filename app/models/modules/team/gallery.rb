class Modules::Team::Gallery < Attachment
  has_attached_file :file, styles: {thumb: '116x116', medium: '460X500#', gallery: '750x350', default_url: 'default.png'}
  validates_attachment_content_type :file, content_type: /\Aimage/
  belongs_to :assetable, polymorphic: true, inverse_of: :images

  attr_accessor :images_ids

  rails_admin do
    visible false
    exclude_fields :type
  end
end