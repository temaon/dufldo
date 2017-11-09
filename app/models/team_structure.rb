class TeamStructure < ApplicationRecord
  include RailsAdmin::TeamStructure

  belongs_to :team, inverse_of: :team_structures
  has_and_belongs_to_many :players,
                          join_table: :team_structures_players,
                          autosave: true

  has_many :home_team_games,  class_name: 'Game',
           foreign_key: :home_team_id,
           dependent: :destroy
  accepts_nested_attributes_for :home_team_games, allow_destroy: true

  has_many :guest_team_games, class_name: 'Game',
           foreign_key: :guest_team_id,
           dependent: :destroy
  accepts_nested_attributes_for :guest_team_games, allow_destroy: true

  has_many :results, dependent: :destroy, class_name: 'Result', inverse_of: :team_structure, foreign_key: :team_structure_id
  accepts_nested_attributes_for :results, allow_destroy: true

  has_many :tournaments, through: :results
  accepts_nested_attributes_for :results, allow_destroy: true

  #Validators
  # validates_presence_of :players
  validates_presence_of :name

  # has_many :home_team_games, class_name: 'Game', inverse_of: :home_team_structure, foreign_key: :home_team_id, :source => :game
  # has_many :guests, class_name: 'Game', inverse_of: :guest, foreign_key: :guest_team_id
  # has_many :visitor_games, class_name: 'Result', inverse_of: :visitor_game

end
