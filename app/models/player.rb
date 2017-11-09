class Player < User
  include Concerns::Sluggable
  include RailsAdmin::Player

  before_validation :add_full_account_info

  TOP_COUNTER = 10

  #impressionist
  is_impressionable counter_cache: true, column_name: :watches_count, unique: :request_hash

  belongs_to :team

  attr_accessor :team_structure_ids

  has_one :photo, as: :assetable, class_name: 'Modules::Player::Image', dependent: :delete, inverse_of: :assetable
  accepts_nested_attributes_for :photo, allow_destroy: true

  has_one :profile, class_name: 'PlayerProfile', dependent: :delete, foreign_key: :user_id, inverse_of: :player
  accepts_nested_attributes_for :profile, allow_destroy: true

  has_one :career, dependent: :delete, inverse_of: :player
  accepts_nested_attributes_for :career, allow_destroy: true

  has_and_belongs_to_many :team_structures, join_table: :team_structures_players
  accepts_nested_attributes_for :team_structures, allow_destroy: true

  has_many :team_structures, through: :team

  has_many :home_team_games, -> {joins(home_team_structure: :players).where('team_structures_players.player_id = users.id').uniq}, through: :team_structures
  has_many :guest_team_games, -> {joins(guest_team_structure: :players).where('team_structures_players.player_id = users.id').uniq}, through: :team_structures


  scope :finder, -> (data) {includes(:team, :photo, :slug).references(:team, :photo, :slug).where(type: 'Player').where('users.id=? OR slugs.slug=?', data, data)}
  scope :top_players, -> (counter = TOP_COUNTER) {includes(:team, :photo, :slug, :career, :profile).references(:team, :photo, :slug, :career, :profile).order('careers.goals_count').limit(counter)}

  def title
    "#{profile.try(:full_name) || profile.try(:name) || username} - #{team.try(:name) || 'без команды'}"
  end

  def add_full_account_info
    uniq_key = SecureRandom.hex(10)
    self.username = username.presence || uniq_key
    self.email = email.presence || "#{uniq_key}@mail.com"
    self.password = password || uniq_key
    self.profile ||= build_profile
    self.career ||= build_career
  end

  def past_matches_count
    @games_cont ||= self.home_team_games.recent_results.count + self.guest_team_games.recent_results.count
  end

  private

  def assign_default_role
    self.add_role(:player) if self.roles.blank?
  end
end