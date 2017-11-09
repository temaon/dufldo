class GamesController < ApplicationController

  before_action :finder, only: [:show]


  # GET /games/1
  # GET /games/1.json
  def show

  end

  private

  def finder
    @object = Game.finder(params[:id], params[:tournament_id]).try(:first)
    unless @object.present?
      raise ActionController::RoutingError.new('Not Found')
    end
    @object = @object.decorate if @object.present?
  end

end
