class Modules::Game::Image < Attachment
  has_attached_file :file, styles: {thumb: '116x116', medium: '460X500#', gallery: '750x350', default_url: 'default.jpg'}
  validates_attachment_content_type :file, content_type: /\Aimage/
  belongs_to :assetable, polymorphic: true, inverse_of: :images

  rails_admin do
    visible false
    exclude_fields :type
  end
end