class Game < ApplicationRecord
  include RailsAdmin::Game
  include Concerns::Sluggable

  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  belongs_to :round, dependent: :destroy, inverse_of: :games
  belongs_to :home_team_structure, class_name: 'TeamStructure', foreign_key: :home_team_id
  belongs_to :guest_team_structure, class_name: 'TeamStructure', foreign_key: :guest_team_id
  has_one :tournament, dependent: :destroy, inverse_of: :games, through: :round

  has_one :first_time, class_name: 'Modules::Game::FirstTime', inverse_of: :game
  accepts_nested_attributes_for :first_time, allow_destroy: true

  has_one :second_time, class_name: 'Modules::Game::SecondTime', inverse_of: :game
  accepts_nested_attributes_for :second_time, allow_destroy: true

  has_one :extra_time, class_name: 'Modules::Game::ExtraTime', inverse_of: :game
  accepts_nested_attributes_for :extra_time, allow_destroy: true

  has_one :video, as: :assetable, class_name: 'Modules::Game::Video', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :video, allow_destroy: true

  has_many :images, as: :assetable, class_name: 'Modules::Game::Image', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :images, allow_destroy: true

  scope :finder, -> (data, tournament = nil) {includes(:tournament, :round, :slug).references(:tournament, :round, :slug).where('games.id=? OR slugs.slug=?', data, data)}

  validates_presence_of :round, presence: true
  validates_presence_of :guest_team_structure, presence: true
  validates_presence_of :home_team_structure, presence: true
  validates_uniqueness_of :guest_team_id, scope: :round_id
  validates_uniqueness_of :home_team_id, scope: :round_id

  def title
    (home_team_structure.present? && guest_team_structure.present?) ? "#{home_team_structure.team.try(:name)} vs #{guest_team_structure.team.try(:name)}" : "Игра"
  end

  def players
    home_team_players = home_team_structure.try(:players) || []
    guest_team_players = guest_team_structure.try(:players) || []
    home_team_players + guest_team_players
  end

  #Url-generation
  def slug_field
    :title
  end

  def slug_field_nested
    :merge_slugs
  end

  def merge_slugs
    "#{try(:round).try(:tournament).try(:slug).try(:slug)}-#{round.name}"
  end



end
