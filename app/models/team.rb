class Team < ApplicationRecord
  include Concerns::Sluggable
  include RailsAdmin::Team

  after_create :set_default_structure

  has_one :logo, as: :assetable, class_name: 'Modules::Team::Logo', dependent: :delete, inverse_of: :assetable
  accepts_nested_attributes_for :logo, allow_destroy: true

  has_one :main_image, as: :assetable, class_name: 'Modules::Team::Image', dependent: :delete, inverse_of: :assetable
  accepts_nested_attributes_for :main_image, allow_destroy: true

  has_many :images, as: :assetable, class_name: 'Modules::Team::Gallery', dependent: :delete_all, inverse_of: :assetable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :players

  has_many :team_structures, inverse_of: :team, dependent: :destroy
  accepts_nested_attributes_for :team_structures, allow_destroy: true

  #Validators
  validates_presence_of :name
  validates_presence_of :logo
  # validates_presence_of :team_structures

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  def set_default_structure
    self.team_structures << TeamStructure.new(name: "#{name} - основной", players: players)
    self.save
  end

  def create_associated_image(image)
    images.create(file: image)
  end

  scope :finder, -> (data) {eager_load(:team_structures, :players, :slug, :main_image, :images).where('teams.id=? OR slugs.slug=?', data, data)}

  searchable do
    text :name, :description
    text :players do
      players.map { |player| player.profile.name }
    end

    string  :slug_title do
      slug.try(:slug)
    end
  end

end
