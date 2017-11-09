class Tournament < ApplicationRecord
  include Concerns::Sluggable
  include RailsAdmin::Tournament
  include Concerns::Commentable

  LATEST_TOURNAMENTS_LIMIT = 9
  RECENT_RESULTS_LIMIT = 8

  validates :title, presence: true
  validates :tournament_category, presence: true
  validates :description, presence: true

  alias_attribute :category, :tournament_category
  belongs_to :tournament_category, class_name: 'TournamentCategory', foreign_key: :category_id, inverse_of: :posts

  has_many :images, as: :assetable, class_name: 'Modules::Tournament::Image', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :documents, as: :assetable, class_name: 'Modules::Tournament::Document', dependent: :destroy, inverse_of: :assetable
  accepts_nested_attributes_for :documents, allow_destroy: true

  has_and_belongs_to_many :team_structures, join_table: :tournaments_team_structures

  has_many :teams, through: :team_structures

  has_many :rounds, inverse_of: :tournament, dependent: :destroy
  accepts_nested_attributes_for :rounds, limit: 15, allow_destroy: true

  has_many :games, through: :rounds

  has_many :recent_results, -> {
          eager_load(round: :tournament).where('tournaments.is_main = ?', true)
         .where('games.date < ? AND (games.guest_team_result IS NOT NULL OR games.home_team_result IS NOT NULL)',  Date.today() + 1.day).order('date DESC')
  }, source: :games, through: :rounds, class_name: 'Game'

  has_many :future_games, -> {
          eager_load(round: :tournament).where('tournaments.is_main = ?', true)
          .where('games.date > ? AND (games.guest_team_result IS NULL OR games.home_team_result IS NULL)',  Date.today() + 1.day)
  }, source: :games, through: :rounds, class_name: 'Game'

  has_many :results, -> { order 'place' }, dependent: :destroy, class_name: 'Result', inverse_of: :tournament, foreign_key: :tournament_id
  accepts_nested_attributes_for :results, allow_destroy: true

  has_and_belongs_to_many :regulations, class_name: 'Regulation'

  acts_as_taggable
  paginates_per 20

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  default_scope ->{includes(:tournament_category, :images, :slug, :results)}

  scope :finder, -> (data) {references(:tournament_category, :images, :slug, :teams, :team_structures, :games, :results).where('tournaments.id=? OR slugs.slug=?', data, data)}

  scope :latest, -> (limit = LATEST_TOURNAMENTS_LIMIT){order(created_at: :desc).limit(limit)}

  scope :get_recent_results, -> {
    references(:recent_results).joins(:recent_results)
  }

  scope :get_future_games, -> {
    references(:future_games).joins(:future_games)
  }

  scope :main_scope, -> (limit = RECENT_RESULTS_LIMIT){
    joins(:results, rounds: :games).where('tournaments.is_main = ?', true).latest(limit)
  }

  def create_associated_image(image)
    images.create(file: image)
  end

  def slug_field
    :title
  end

  def slug_field_nested
    :category
  end

end
