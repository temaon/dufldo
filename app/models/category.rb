class Category < ApplicationRecord
  include Concerns::Sluggable

  #Relations
  has_one :main_image, as: :assetable, class_name: 'Modules::Category::Image', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :main_image, allow_destroy: true

  #Validators
  validates :name, presence: true

  #Scopes
  default_scope ->{includes(:slug, children: [:slug])}
  scope :finder, -> (data) {references(:slug, children: :slug).includes(:slug, children: :slug).where('categories.id=? OR slugs.slug=?', data, data)}
  scope :slugable, -> {}

  acts_as_nested_set

  rails_admin do
    nested_set({
                   max_depth: 2,
                   toggle_fields: [:enabled],
                   thumbnail_fields: [:image, :cover],
                   thumbnail_size: :thumb,
                   thumbnail_gem: :paperclip,
               })
  end

  #Url-generation
  def slug_field
    :name
  end

  def slug_field_nested
    :parent
  end

  def self.build_default_object
    return unless self.respond_to? :get_default_properties
    prop =  self.get_default_properties
    self.new(
        name: prop[:title],
        slug: Slug.new(slug: prop[:slug]),
        main_image: Modules::Category::Image.new()
    )
  end

  def title
    parent.present? ? "#{parent.try(:name)}::#{read_attribute(:name)}" : read_attribute(:name)
  end

end