class Modules::Team::Logo < Attachment
  has_attached_file :file, styles: {thumb: '175x175#', gallery: '175x211#', default_url: 'default.png'}
  validates_attachment_content_type :file, content_type: /\Aimage/
  belongs_to :assetable, polymorphic: true, inverse_of: :logo

  def title
    "#{id}-image"
  end

  rails_admin do
    visible false
    exclude_fields :type
  end

end