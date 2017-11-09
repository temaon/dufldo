class Round < ApplicationRecord
  include RailsAdmin::Round

  has_many :games, dependent: :destroy, autosave: true, inverse_of: :round
  accepts_nested_attributes_for :games, allow_destroy: true, limit: 15

  belongs_to :tournament, inverse_of: :rounds, dependent: :destroy, autosave: true

  # before_save :set_round_name
  validates_presence_of :tournament, presence: true
  # validates_presence_of :name, presence: true
  # validates_uniqueness_of :name, scope: :tournament_id
  # validates :name,  numericality: {greater_than_or_equal_to: 1}, uniqueness: :name

  validates :name, presence: true, uniqueness: {scope: :tournament_id}
  # def set_round_name
    # self.name = name.present? ? name : tournament.rounds.size.next.to_s
  # end

  def title
    "#{tournament.title} - #{name}" if tournament.present?
  end

  def formatted_title
    "#{name} - й тур"
  end

end
