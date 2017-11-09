class GameEvent < ApplicationRecord
  belongs_to :timeline, inverse_of: :game_events

  belongs_to :player, class_name: 'Player'

  validates :event_type, presence: true

  validates :time, numericality: { only_integer: true, positive: true }

  enum event_type: [:goal, :replacement, :red_card, :yellow_card]

  after_create :inc_goals_for_user
  after_destroy :dec_goals_for_user


  def inc_goals_for_user
    if player.present? && goal?
      player.try(:career).try(:increment, :goals_count)
    end
  end

  def dec_goals_for_user
    if player.present? && goal?
      player.try(:career).try(:decrement, :goals_count)
    end
  end

  def title
    try(:event_type).to_s
  end

  rails_admin do
    visible false
    label 'Событие'
    exclude_fields :created_at,
                   :updated_at

    # field :player do
    #   associated_collection_scope do
    #     extend Concerns::Extensions
    #     object, value = if object.class.to_s == 'Game'
    #                       self.find_nested_query(bindings[:controller].params, :players)
    #                     elsif object.class.to_s == 'tournament'
    #                     end
    #     Proc.new do |scope|
    #     end
    #   end
    # end

  end

end
