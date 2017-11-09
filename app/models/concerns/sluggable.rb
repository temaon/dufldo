module Concerns::Sluggable
  extend ActiveSupport::Concern

  included do

    before_validation :set_slug
    before_save :check_all_nested_slugs

    has_one :slug, as: :slugable, dependent: :destroy, inverse_of: :slugable
    accepts_nested_attributes_for :slug, allow_destroy: true

    def set_slug
      slug_field = self.try(:slug_field)
      parent_filed = self.try(:slug_field_nested)
      if slug_field.present?
        slug_value = self.send(slug_field).to_s.to_url
        parent_obj = self.send(parent_filed) if parent_filed.present?
        slug_parent = parent_obj.is_a?(String) ? parent_obj : parent_obj.try(:slug).try(:slug).to_s
        self.slug.present? ? self.slug.slug = File.join(slug_parent, slug_value) :
            self.build_slug.slug = File.join(slug_parent, slug_value)
      end
    end

    def check_all_nested_slugs
      if self.slug.changed? && self.slug.slug_was.present?
        nested_records = Slug.unscoped.where('slugs.slug LIKE ?', "#{self.slug.slug_was}%").where.not(slugable: self)
        nested_records.each do |record|
          record.slug.gsub(self.slug.slug_was, self.slug.slug)
          record.save! if record.changed?
        end
      end
    end
  end


end