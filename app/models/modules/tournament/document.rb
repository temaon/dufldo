class Modules::Tournament::Document < Attachment
  has_attached_file :file
  validates_attachment :file, content_type: {content_type: %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
  belongs_to :assetable, polymorphic: true, inverse_of: :documents

  def title
    "#{id}-document"
  end

  rails_admin do
    visible false
    exclude_fields :type
  end
end