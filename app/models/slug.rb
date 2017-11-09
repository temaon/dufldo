class Slug < ApplicationRecord
  belongs_to :slugable, polymorphic: true, inverse_of: :slug

  after_save :reload_router
  after_create :reload_router

  validates_format_of :slug, with: /(^\/)/i, if: 'slug.present?'
  validates :slug, uniqueness: true, if: 'slug.present?'

  private

  def reload_router
    Rails.application.reload_routes!
  end

  rails_admin do
    field :slug do
      read_only true
    end
  end

end
